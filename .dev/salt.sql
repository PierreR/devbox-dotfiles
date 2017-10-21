-- SALT SCHEMA

CREATE TABLE IF NOT EXISTS jids  (
   jid varchar(255) NOT NULL primary key,
   load jsonb NOT NULL
);
CREATE INDEX idx_jids_jsonb on jids
       USING gin (load)
       WITH (fastupdate=on);

CREATE TABLE IF NOT EXISTS salt_returns (
  fun varchar(50) NOT NULL,
  jid varchar(255) NOT NULL,
  return jsonb NOT NULL,
  id varchar(255) NOT NULL,
  success varchar(10) NOT NULL,
  full_ret jsonb NOT NULL,
  alter_time TIMESTAMP WITH TIME ZONE DEFAULT NOW());
CREATE INDEX idx_salt_returns_id ON salt_returns (id);
CREATE INDEX idx_salt_returns_jid ON salt_returns (jid);
CREATE INDEX idx_salt_returns_fun ON salt_returns (fun);
CREATE INDEX idx_salt_returns_return ON salt_returns
    USING gin (return) with (fastupdate=on);
CREATE INDEX idx_salt_returns_full_ret ON salt_returns
    USING gin (full_ret) with (fastupdate=on);

CREATE TABLE IF NOT EXISTS salt_events (
           id serial primary key,
    tag varchar(255) NOT NULL,
    data jsonb NOT NULL,
    alter_time TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    master_id varchar(255) NOT NULL);
CREATE INDEX idx_salt_events_tag on
    salt_events (tag);
CREATE INDEX idx_salt_events_data ON salt_events
    USING gin (data) with (fastupdate=on);

CREATE VIEW salt_result AS
    SELECT J.jid as jid, J.load->>'user' as user, J.load->>'tgt' as target, json_agg(R.full_ret) as ret
    FROM jids as J, salt_returns as R
    WHERE J.jid = R.jid  and J.load ? 'user'
    GROUP BY J.jid
    ORDER BY J.load->>'jid', jid desc;


-- RESULT NOTIFICATION

CREATE OR REPLACE FUNCTION notify_result() RETURNS TRIGGER AS $$

DECLARE
data jsonb;
notification json;
chan text;

BEGIN

SELECT J.load->>'user' into chan from jids as J where jid = NEW.jid;
notification = NEW.full_ret;

-- Execute pg_notify(channel, notification)
PERFORM pg_notify(chan,notification::text);

-- Result is ignored since this is an AFTER trigger
RETURN NULL;
END;

$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS notify_result on salt_returns;
CREATE TRIGGER notify_result AFTER INSERT ON salt_returns
    FOR EACH ROW EXECUTE PROCEDURE notify_result();