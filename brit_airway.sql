//Creating storage integration 
CREATE or replace STORAGE INTEGRATION britblob_int
TYPE = EXTERNAL_STAGE
STORAGE_PROVIDER = 'AZURE'
ENABLED = TRUE
AZURE_TENANT_ID = ''
STORAGE_ALLOWED_LOCATIONS = ('');

DESC STORAGE INTEGRATION azure_int; --TAKE SNOWFLAKE ID FOR BLOB FROM HERE

CREATE OR REPLACE NOTIFICATION INTEGRATION BRIT_INT
ENABLED=TRUE
TYPE=QUEUE
NOTIFICATION_PROVIDER=AZURE_STORAGE_QUEUE
AZURE_STORAGE_QUEUE_PRIMARY_URI=''
AZURE_TENANT_ID='';

show integrations;

DESC NOTIFICATION INTEGRATION BRIT_INT; --TAKE SNOWFLAKE ID FOR QUEUE FROM HERE

create or replace stage britstage
url=''
credentials=(azure_sas_token='');

show stages;

//PIPELINE

create or replace pipe snowpipe_brit_airways
auto_ingest=true
integration='BRIT_INT'
as
copy into brit_airways_data
from @britstage
file_format=(type='CSV');

alter pipe snowpipe_brit_airways refresh;
