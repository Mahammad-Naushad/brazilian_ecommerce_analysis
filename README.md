# Brazilian E-Commerce Data Pipeline

## Project Overview
This project implements a professional Medallion Architecture using **Databricks** and **Unity Catalog** to process 100k+ rows of Olist e-commerce data. The goal was to transform raw, multilingual transactional data into a "BI-ready" **Star Schema**, focusing on data governance, performance optimization, and auditability.

## Architecture & Governance
I utilized the Unity Catalog to manage data access and lineage across three distinct layers:

### 1. Bronze Layer (Raw Ingestion)

- **Direct Ingestion:** Streamlined the process by reading raw CSV files directly into Unity Catalog as Delta tables.
- **Data Preservation**: Maintained the original state of the data, including Portuguese headers and raw string formats, to ensure a "Single Source of Truth" for auditing.

### 2. Silver Layer (Cleansing & Enrichment)
This layer focuses on standardization and preparing data for analysis:

- **Modular Pipeline**: Developed a reusable Python utility function, write_silver_table, to standardize metadata injection and Delta writes.
- **Data Enrichment**:
   - **Geospatial**: Aggregated 1M+ geolocation points into a deduplicated zip-code reference table.
   - **Translation**: Broadcast-joined a Portuguese-to-English mapping to make product categories globally readable.
   - **Regional Mapping**: Enriched customer and seller records with full Brazilian state names using efficient Broadcast Joins.
- **Auditability**: Injected _ingested_at timestamps and _source_file metadata into every record for full data lineage.
- **Data Quality**: Filtered out null reviews and non-positive payments to ensure downstream integrity.

### 3. Gold Layer (Business Logic - Work in Progress)

- Implementing a Star Schema designed for high-performance BI reporting.
- Transforming Silver tables into a central Fact_Sales table and associated Dimension tables (dim_products, dim_customers).

## Technical Optimizations
- **Delta Lake Features**: Leveraged Auto-Optimize and Auto-Compaction table properties to solve the "Small File Problem".
- **Schema Evolution**: Used mergeSchema options to ensure the pipeline remains resilient to source data changes.
- **Memory Management**: Utilized broadcast() for small lookup tables to avoid expensive Spark shuffles.

## Tech Stack
**Language:** PySpark (Python)

**Platform:** Databricks (Runtime 13.3+)

**Storage & Governance:** Unity Catalog, Delta Lake

**Architecture:** Medallion (Bronze, Silver, Gold)