# MySQL to PostgreSQL Migration Guide

## 1. Project Flow

```text
MySQL RDS
    │
    │ Schema
    ▼
AWS Schema Conversion Tool (SCT)
    │
    │ Converted Schema
    ▼
PostgreSQL RDS
    ▲
    │ Data
    │
AWS Database Migration Service (DMS)
    ▲
    │
MySQL RDS
```

---

## 2. Migration Steps

### Step 1 — Prepare MySQL RDS

Create the MySQL RDS database and configure connectivity.

```text
Engine: MySQL
Port: 3306
Role: Source
```

Create the source database:

```sql
CREATE DATABASE source_ecommerce;
```

---

### Step 2 — Prepare PostgreSQL RDS

Create the PostgreSQL RDS database.

```text
Engine: PostgreSQL
Port: 5432
Role: Target
```

Create the target database:

```sql
CREATE DATABASE target_ecommerce;
```

The project uses separate RDS instances for the MySQL source and PostgreSQL target.

---

### Step 3 — Configure AWS SCT

Open AWS SCT and configure the MySQL and PostgreSQL JDBC drivers.

```text
Settings
 → Global Settings
 → Drivers
```

Then create a new SCT project.

---

### Step 4 — Connect MySQL Source

Add the MySQL RDS instance as the SCT source.

```text
Add Source
 → MySQL
```

Provide:

```text
MySQL RDS Endpoint
Port: 3306
Username
Password
```

Test the connection.

---

### Step 5 — Connect PostgreSQL Target

Add PostgreSQL RDS as the SCT target.

```text
Add Target
 → Amazon RDS for PostgreSQL
```

Provide:

```text
PostgreSQL RDS Endpoint
Port: 5432
Username
Password
```

Test the connection.

---

### Step 6 — Convert Schema

In AWS SCT:

```text
Source Database
 → Create Mapping
 → Create Report
 → Convert Schema
```

Review the conversion report and convert the required database objects.

---

### Step 7 — Apply Schema

On the PostgreSQL target:

```text
Target Database
 → Schema
 → Apply to Database
```

This creates the converted schema on PostgreSQL.

---

### Step 8 — Configure AWS DMS

Create:

```text
DMS Replication Instance
```

Then create:

```text
Source Endpoint
       ↓
MySQL RDS

Target Endpoint
       ↓
PostgreSQL RDS
```

---

### Step 9 — Create Migration Task

Create a DMS migration task using:

```text
Source Endpoint
        ↓
Replication Instance
        ↓
Target Endpoint
```

Start the migration task.

The project documentation specifies creating the replication instance, endpoints, migration task, and starting the task.

---

## 3. Data Validation

After the migration completes, connect to PostgreSQL.

Run:

```sql
SELECT *
FROM source_ecommerce.departments;
```

Verify that the migrated records are available in PostgreSQL.

---

## 4. Validation Checklist

```text
☑ MySQL RDS created
☑ PostgreSQL RDS created
☑ SCT configured
☑ MySQL source connected
☑ PostgreSQL target connected
☑ Schema assessment completed
☑ Schema converted
☑ Schema applied to PostgreSQL
☑ DMS replication instance created
☑ DMS source endpoint created
☑ DMS target endpoint created
☑ DMS migration task started
☑ Data migrated
☑ PostgreSQL data validated
```

---

## 5. Final Result

```text
             SOURCE
          MySQL RDS
              │
              │
        ┌─────▼─────┐
        │    SCT    │
        │   Schema  │
        │ Conversion│
        └─────┬─────┘
              │
              ▼
       PostgreSQL Schema
              │
              │
        ┌─────▼─────┐
        │    DMS    │
        │   Data    │
        │ Migration │
        └─────┬─────┘
              │
              ▼
       PostgreSQL RDS
            TARGET
```

The final result is a PostgreSQL database containing the migrated schema and data from the MySQL source database.
