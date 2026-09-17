# AWS Database Migration Service (DMS)

## Overview

AWS Database Migration Service (DMS) is used to migrate the data from the **MySQL RDS source database** to the **PostgreSQL RDS target database**.

The migration flow is:

```text
MySQL RDS
    │
    ▼
DMS Source Endpoint
    │
    ▼
DMS Replication Instance
    │
    ▼
DMS Migration Task
    │
    ▼
DMS Target Endpoint
    │
    ▼
PostgreSQL RDS
```

---

## 1. Create Replication Instance

Open:

```text
AWS Console
    ↓
Database Migration Service (DMS)
    ↓
Replication instances
    ↓
Create replication instance
```

Configure the required instance settings and create the replication instance.

The replication instance performs the migration between the source and target databases.

---

## 2. Create Source Endpoint

Create an endpoint for the MySQL RDS database.

```text
Endpoint Type: Source
Engine: MySQL
Server Name: <MYSQL_RDS_ENDPOINT>
Port: 3306
Database: source_ecommerce
Username: <MYSQL_USERNAME>
Password: <MYSQL_PASSWORD>
```

Test the endpoint connection.

---

## 3. Create Target Endpoint

Create an endpoint for the PostgreSQL RDS database.

```text
Endpoint Type: Target
Engine: PostgreSQL
Server Name: <POSTGRES_RDS_ENDPOINT>
Port: 5432
Database: target_ecommerce
Username: <POSTGRES_USERNAME>
Password: <POSTGRES_PASSWORD>
```

Test the endpoint connection.

The project documentation specifies creating endpoints for both the source and target databases.

---

## 4. Create Migration Task

Go to:

```text
AWS DMS
    ↓
Database migration tasks
    ↓
Create task
```

Select:

```text
Source endpoint:
MySQL_RDS

Target endpoint:
PostgreSQL_RDS

Replication instance:
<YOUR_REPLICATION_INSTANCE>
```

For this project, configure the task for the required data migration.

---

## 5. Start Migration

After creating the task:

```text
Migration Task
    ↓
Start
```

Monitor the task status until the migration completes.

The project documentation follows the sequence of creating the replication instance, creating both endpoints, creating the task, and starting the task.

---

## 6. Monitor Migration

Check the migration task for:

```text
Task Status
Table Statistics
Records Loaded
Records Applied
Errors
```

Make sure the migration task completes successfully.

---

## 7. Validate PostgreSQL Database

After migration, connect to PostgreSQL.

Run:

```sql
SELECT *
FROM source_ecommerce.departments;
```

Verify that the records migrated from MySQL are available in PostgreSQL.

The project documentation uses a PostgreSQL query to verify the migrated `Departments` data.

---

## 8. Migration Validation

Compare the source and target databases.

### Source

```text
MySQL RDS
    ↓
departments
```

### Target

```text
PostgreSQL RDS
    ↓
departments
```

Verify:

* Table exists
* Columns exist
* Records are present
* Data is correct

---

## Architecture

```text
             AWS DMS
                │
                ▼
┌──────────────────────┐
│ MySQL RDS            │
│ Source Database      │
└──────────┬───────────┘
           │
           ▼
┌──────────────────────┐
│ Source Endpoint      │
└──────────┬───────────┘
           │
           ▼
┌──────────────────────┐
│ Replication Instance │
└──────────┬───────────┘
           │
           ▼
┌──────────────────────┐
│ Target Endpoint      │
└──────────┬───────────┘
           │
           ▼
┌──────────────────────┐
│ PostgreSQL RDS       │
│ Target Database      │
└──────────────────────┘
```

---

## Screenshots

Add your DMS screenshot:

```markdown
![AWS DMS Migration Task](../screenshots/dms-task.png)
```

Recommended screenshots:

1. DMS Replication Instance
2. Source Endpoint
3. Target Endpoint
4. Migration Task
5. Successful Migration
6. Table Statistics

---

## Security Note

Never commit real credentials to GitHub.

Use placeholders:

```text
<MYSQL_RDS_ENDPOINT>
<POSTGRES_RDS_ENDPOINT>
<MYSQL_USERNAME>
<POSTGRES_USERNAME>
<DB_PASSWORD>
```

Never upload:

```text
.env
AWS Access Keys
AWS Secret Keys
Database Passwords
```
