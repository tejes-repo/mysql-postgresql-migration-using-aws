# AWS Schema Conversion Tool (SCT)

## Overview

AWS Schema Conversion Tool (SCT) is used in this project to convert the **MySQL source database schema** into a **PostgreSQL-compatible schema**.

Migration flow:

```text
MySQL RDS
    │
    ▼
AWS Schema Conversion Tool
    │
    ├── Analyze Schema
    ├── Create Mapping
    ├── Generate Assessment Report
    └── Convert Schema
    │
    ▼
PostgreSQL RDS
```

---

## 1. Install AWS SCT

Install AWS Schema Conversion Tool on the local system.

Required JDBC drivers:

* MySQL JDBC Driver
* PostgreSQL JDBC Driver

The project documentation specifies configuring these drivers before connecting the databases.

---

## 2. Configure Database Drivers

Open AWS SCT:

```text
Settings
    ↓
Global Settings
    ↓
Drivers
```

Add the paths for:

```text
MySQL JDBC Driver
PostgreSQL JDBC Driver
```

Then click:

```text
Apply → OK
```

---

## 3. Create SCT Project

Open AWS SCT and select:

```text
File
    ↓
New Project
```

Enter:

```text
Project Name
Local Store Path
```

---

## 4. Add MySQL Source

Select:

```text
Add Source
    ↓
MySQL
```

Configure the connection:

```text
Connection Name: MySQL_RDS
Server Name: <MYSQL_RDS_ENDPOINT>
Port: 3306
Username: <MYSQL_USERNAME>
Password: <MYSQL_PASSWORD>
```

Click:

```text
Test Connection
```

After a successful connection, click **Connect**.

The project uses the MySQL RDS endpoint as the source database.

---

## 5. Add PostgreSQL Target

Select:

```text
Add Target
    ↓
Amazon RDS for PostgreSQL
```

Configure:

```text
Connection Name: PostgreSQL_RDS
Server Name: <POSTGRES_RDS_ENDPOINT>
Port: 5432
Username: <POSTGRES_USERNAME>
Password: <POSTGRES_PASSWORD>
```

Click:

```text
Test Connection
```

After successful testing, click **Connect**.

The project uses PostgreSQL RDS as the target database.

---

## 6. Select Source Database

From the left side of AWS SCT:

```text
Server
   ↓
Schema
   ↓
source_ecommerce
```

Select the database checkbox.

Then click:

```text
Create Mapping
```

This creates the mapping between the source MySQL database and the target PostgreSQL database.

---

## 7. Generate Assessment Report

Right-click the source database:

```text
source_ecommerce
```

Select:

```text
Create Report
```

The assessment report can be used to review the database objects and conversion information before applying the converted schema.

---

## 8. Convert Schema

Right-click:

```text
source_ecommerce
```

Select:

```text
Convert Schema
```

AWS SCT converts the MySQL schema into a PostgreSQL-compatible schema.

---

## 9. Apply Schema to PostgreSQL

On the target side:

```text
PostgreSQL
   ↓
Schema
   ↓
source_ecommerce
```

Right-click the converted database/schema and select:

```text
Apply to Database
```

This applies the converted schema to the PostgreSQL target database.

---

## 10. Verification

After applying the schema, verify the target PostgreSQL database.

Check:

* Database
* Schemas
* Tables
* Columns
* Constraints

The actual **data migration is performed separately using AWS DMS**.

```text
AWS SCT
   │
   └── Schema Conversion
          ↓
     PostgreSQL Schema

AWS DMS
   │
   └── Data Migration
          ↓
     PostgreSQL Data
```

---

## Screenshots

Add the SCT screenshot below:

```markdown
![AWS SCT Schema Conversion](../screenshots/sct-schema-conversion.png)
```

---

## Important Security Note

Never commit real database credentials to GitHub.

Use placeholders:

```text
<MYSQL_RDS_ENDPOINT>
<POSTGRES_RDS_ENDPOINT>
<DB_USERNAME>
<DB_PASSWORD>
```

Do not upload:

```text
.env
passwords
AWS access keys
AWS secret keys
database credentials
```
