import pandas as pd
from google.cloud import bigquery, bigquery_storage

client = bigquery.Client(project="tamara-44603")
bqstorage_client = bigquery_storage.BigQueryReadClient()


