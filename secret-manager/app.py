import boto3
import pymysql
import json
import os

def get_secret(secret_name, region_name="us-east-1"):
    client = boto3.client("secretsmanager", region_name=region_name)
    response = client.get_secret_value(SecretId=secret_name)
    return json.loads(response['SecretString'])

def connect_to_db():
    secret_name = os.getenv("SECRET_NAME", "my-python-rds-secret")
    print(f"Retrieving secret: {secret_name}")
    try:
        creds = get_secret(secret_name)
    except Exception as e:
        print(f"Error retrieving secret: {e}")
        return


    try:
        connection = pymysql.connect(
            host=creds["host"],
            user=creds["username"],
            password=creds["password"],
            db=creds["dbname"],
            port=int(creds.get("port", 3306))
        )
    except pymysql.MySQLError as db_err:
        print(f"Database connection error: {db_err}")
        return

    try:
        with connection.cursor() as cursor:
            cursor.execute("SELECT NOW();")
            result = cursor.fetchone()
            print("Current DB Time:", result[0])
    except Exception as query_err:
        print(f"Error executing query: {query_err}")
    finally:
        connection.close()

if __name__ == "__main__":
    print("Starting secret manager application...")
    connect_to_db()
