# Secret Manager Application

This application retrieves secrets from AWS Secrets Manager and connects to a MySQL database using the credentials.

## Prerequisites

- Python 3.7+
- AWS credentials configured (for boto3)
- MySQL database accessible

## Setup

Run the setup script to install dependencies:
```sh
setup.bat
```

## Usage

Set the environment variable for your secret name (Command Prompt):
```sh
set SECRET_NAME=your-secret-name
```

Run the application:
```sh
python app.py
```

## How it works

- Retrieves database credentials from AWS Secrets Manager.
- Connects to the MySQL database using the credentials.
- Executes a simple query to display the current database time.

## Error Handling

The application prints error messages if it fails to retrieve secrets, connect to the database, or execute queries.

## License

MIT