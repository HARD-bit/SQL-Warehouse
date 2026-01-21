
### Layers Description
- **Staging**: raw data ingestion and basic cleansing
- **Warehouse**: modeled tables using a **star schema**
- **Analytics**: optimized views for reporting and analysis

---

## 🧱 Data Model
The warehouse uses a **Star Schema** composed of:

### Fact Tables
- `fact_sales`
- `fact_orders`
- `fact_events`

### Dimension Tables
- `dim_customer`
- `dim_product`
- `dim_date`
- `dim_location`

This structure enables efficient analytical queries and scalable reporting.

---

## 🔄 ETL / ELT Process
The data pipeline includes:

1. **Extraction**
   - Source systems (CSV, APIs, transactional DBs)
2. **Transformation**
   - Data cleaning
   - Deduplication
   - Type casting
   - Business logic implementation
3. **Loading**
   - Insert into dimension tables
   - Populate fact tables with surrogate keys

All transformations are implemented using **pure SQL**.

---

## 🧪 Data Quality Checks
- Null checks on primary keys
- Referential integrity validation
- Duplicate detection
- Consistency checks across dimensions

---

## 🚀 Technologies Used
- **SQL** (PostgreSQL / MySQL / Snowflake / BigQuery)
- **Database**: Relational Data Warehouse
- **Version Control**: Git & GitHub
- **Optional**:
  - dbt
  - Airflow
  - BI Tools (Power BI, Tableau)

---

## 🎯 Project Goals
- Apply Data Warehouse modeling principles
- Improve SQL query performance
- Build analytics-ready datasets
- Demonstrate real-world Data Engineering skills

---

## 📈 Future Improvements
- Add incremental loads
- Implement Slowly Changing Dimensions (SCD Type 2)
- Integrate orchestration (Airflow)
- Add automated tests
- Connect BI dashboards

---

## 👤 Author
**Gabriele Rumi**  
Data Engineer | SQL | Data Warehousing


## 📂 Project Structure
