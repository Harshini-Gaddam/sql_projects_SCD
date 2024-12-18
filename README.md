# Slowly Changing Dimensions (SCD)

Slowly Changing Dimensions (SCD) refer to the method of handling changes in the dimensional data of a data warehouse over time. These dimensions often contain descriptive attributes that may change infrequently but still require historical tracking and accuracy for analytical purposes.

---

## Types of Slowly Changing Dimensions

### 1. Type 0: Passive Retention
- **Description**: No changes are made to the dimension data, and historical data is retained as-is.
- **Use Case**: When historical accuracy is critical, and no updates are allowed.

### 2. Type 1: Overwrite
- **Description**: Updates the existing dimension record with the latest data, overwriting the old values.
- **Pros**: Simple and efficient; no historical data is retained.
- **Use Case**: When historical changes are irrelevant (e.g., correcting a typo).

### 3. Type 2: Add Row
- **Description**: Creates a new row for every change, with additional columns to track the effective dates of the record.
- **Pros**: Preserves full historical data.
- **Use Case**: When tracking historical changes is required (e.g., customer address history).

### 4. Type 3: Add Column
- **Description**: Adds a new column to store the previous value of the changed attribute.
- **Pros**: Tracks a limited history of changes; less complex than Type 2.
- **Use Case**: When only the current and one prior state need to be tracked (e.g., previous job title).

### 5. Type 4: Historical Table
- **Description**: Maintains historical data in a separate table while keeping only current data in the main dimension table.
- **Pros**: Separates historical tracking from current state, improving query performance.
- **Use Case**: When historical data needs to be managed separately (e.g., tracking product price changes).

### 6. Type 6: Hybrid
- **Description**: Combines features of Type 1, 2, and 3 to maintain current state, historical records, and easy access to prior state.
- **Pros**: Comprehensive solution for tracking current and historical changes.
- **Use Case**: When a mix of current state and historical tracking is required (e.g., customer loyalty program data).

---

## Why SCD is Important
- **Historical Accuracy**: Ensures historical changes are tracked for meaningful analytics.
- **Business Insights**: Provides a complete picture of data evolution over time.
- **Data Integrity**: Maintains consistency in reporting and decision-making processes.

---

This section provides an overview of Slowly Changing Dimensions and their significance in building robust and accurate data warehouses.

