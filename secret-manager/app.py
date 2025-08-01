import boto3
import pymysql
import json
import os

# Retrieve a secret from AWS Secrets Manager.
# Args:
#     secret_name (str): The name of the secret to retrieve.
#     region_name (str): AWS region where the secret is stored.
# Returns:
#     dict: The secret as a dictionary.
def get_secret(secret_name, region_name="us-east-1"):
    client = boto3.client("secretsmanager", region_name=region_name)
    response = client.get_secret_value(SecretId=secret_name)
    return json.loads(response['SecretString'])


# Connect to a MySQL database using credentials from AWS Secrets Manager,
# execute a simple query, and print the current database time.
def connect_to_db():
    secret_name = os.getenv("SECRET_NAME", "my-python-rds-secret")
    print(f"Retrieving secret: {secret_name}")
    try:
        # Retrieve database credentials from AWS Secrets Manager
        creds = get_secret(secret_name)
    except Exception as e:
        print(f"Error retrieving secret: {e}")
        return

    try:
        # Establish a connection to the MySQL database
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
        # Create a cursor, execute a query, and fetch the result
        with connection.cursor() as cursor:
            cursor.execute("SELECT NOW();")  # Get current DB time
            result = cursor.fetchone()
            print("Current DB Time:", result[0])
    except Exception as query_err:
        print(f"Error executing query: {query_err}")
    finally:
        # Ensure the database connection is closed
        connection.close()

if __name__ == "__main__":
    print("Starting secret manager application...")
    connect_to_db()
