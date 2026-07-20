# Vidhaikal NGO Management System — Data Model

**Maps to:** BR-01 through BR-06, FR-01 through FR-08 (2_BRD_Vidhaikal_NGO_Enhanced.docx)
**Status:** Draft for TDD input

---

## 1. Object Summary

| Object API Name | Label | Type | Purpose |
|---|---|---|---|
| `Donor__c` | Donor | Custom | Donor master record (BR-01) |
| `Donation__c` | Donation | Custom | Every gift, of any type (BR-02) |
| `Beneficiary__c` | Beneficiary | Custom | Aid recipient master record (BR-03) |
| `Distribution__c` | Distribution | Custom junction | Links a donation to the beneficiary(ies) it was given to |
| `Volunteer__c` | Volunteer | Custom | Volunteer master record (BR-04) |
| `Campaign__c` | Campaign | Custom | NGO events/drives (BR-05) |
| `Campaign_Volunteer__c` | Campaign Assignment | Custom junction | Volunteer ↔ Campaign, with attendance |
| `User` (standard) | — | Standard | Staff, Coordinators, Admins (login) |

**Why custom objects instead of standard Account/Contact/Campaign:** the BRD's roles matrix (Section 9) and license plan (Section 12) call for tight, purpose-built sharing rules per record type — e.g. Volunteers get "view assigned tasks only" while Beneficiary data is staff-only. Standard objects come with CRM-oriented sharing and page layouts that would need heavy rework; custom objects give a cleaner slate and match the "custom objects, Apex triggers, Flows" approach already scoped in your TDD.

---

## 2. Object Field Specifications

### 2.1 Donor__c

| Field API Name | Label | Type | Notes |
|---|---|---|---|
| Name | Donor Name | Text(120) | Standard Name field |
| Donor_Type__c | Donor Type | Picklist | Individual, Organization |
| Email__c | Email | Email | |
| Phone__c | Phone | Phone | |
| Street__c | Street | Text(255) | |
| City__c | City | Text(80) | |
| State__c | State | Text(80) | |
| Pincode__c | Pincode | Text(10) | |
| Status__c | Status | Picklist | Active, Inactive |
| Total_Donations__c | Total Donations | Roll-Up Summary (Currency, SUM) | From `Donation__c.Amount__c` where Donation_Type = Money |
| Total_Donation_Count__c | Donation Count | Roll-Up Summary (COUNT) | All donation types |

### 2.2 Donation__c

| Field API Name | Label | Type | Notes |
|---|---|---|---|
| Name | Donation Number | Auto Number | Format: `DON-{00000}` — no meaningful text name for a transaction |
| Donor__c | Donor | Master-Detail → Donor__c | Required |
| Campaign__c | Campaign | Lookup → Campaign__c | Optional — most donations aren't campaign-tied |
| Donation_Type__c | Donation Type | Picklist | Money, Food, Clothes, Books, School Supplies |
| Amount__c | Amount | Currency | Required if Donation_Type = Money |
| Quantity__c | Quantity | Number | Required if Donation_Type ≠ Money |
| Unit__c | Unit | Text(20) or Picklist | kg, pieces, boxes, sets |
| Donation_Date__c | Donation Date | Date | Defaults to today |
| Status__c | Status | Picklist | Received (default), Pending, Distributed |
| Notes__c | Notes | Long Text Area | |

**Validation rule:** block save if `Donation_Type__c = 'Money'` and `Amount__c` is blank, or `Donation_Type__c ≠ 'Money'` and `Quantity__c` is blank.

### 2.3 Beneficiary__c

| Field API Name | Label | Type | Notes |
|---|---|---|---|
| Name | Beneficiary Name | Text(120) | Human-entered, e.g. "Lakshmi Devi" |
| Street__c | Street | Text(255) | |
| City__c | City | Text(80) | |
| State__c | State | Text(80) | |
| Pincode__c | Pincode | Text(10) | |
| Family_Size__c | Family Size | Number | |
| Contact_Number__c | Contact Number | Phone | |
| Status__c | Status | Picklist | Active, Inactive |

### 2.4 Distribution__c (junction: Donation ↔ Beneficiary)

| Field API Name | Label | Type | Notes |
|---|---|---|---|
| Name | Distribution Number | Auto Number | Format: `DIST-{00000}` |
| Donation__c | Donation | Master-Detail → Donation__c | Required |
| Beneficiary__c | Beneficiary | Master-Detail → Beneficiary__c | Required (2nd master-detail — supported) |
| Quantity_Distributed__c | Quantity Distributed | Number | Supports partial fulfillment of one donation |
| Distribution_Date__c | Distribution Date | Date | |
| Distributed_By__c | Distributed By | Lookup → User | Staff who handed it over |

**Trigger logic (for TDD):** an Apex trigger on `Distribution__c` sums `Quantity_Distributed__c` against the parent `Donation__c.Quantity__c`; once fully allocated, auto-update `Donation__c.Status__c = 'Distributed'`.

### 2.5 Volunteer__c

| Field API Name | Label | Type | Notes |
|---|---|---|---|
| Name | Volunteer Name | Text(120) | Human-entered, e.g. "Arjun Kumar" |
| Email__c | Email | Email | |
| Phone__c | Phone | Phone | |
| Skills__c | Skills | Multi-Select Picklist | Medical, Teaching, Logistics, Driving, Cooking, Other |
| Availability__c | Availability | Picklist | Weekdays, Weekends, Both |
| Status__c | Status | Picklist | Active, Inactive |
| User__c | Portal User | Lookup → User | Links to Experience Cloud login (Section 12 licensing) |

### 2.6 Campaign__c

| Field API Name | Label | Type | Notes |
|---|---|---|---|
| Name | Campaign Name | Text(120) | Human-entered, e.g. "Tree Plantation Drive - July 2026" |
| Campaign_Type__c | Campaign Type | Picklist | Tree Plantation, Blood Donation, Food Distribution, Educational, Other |
| Campaign_Date__c | Campaign Date | Date | |
| Location__c | Location | Text(255) | |
| Status__c | Status | Picklist | Planned, Ongoing, Completed, Cancelled |
| Coordinator__c | Coordinator | Lookup → User | Volunteer Coordinator, drives sharing (Section 9) |
| Outcome_Metric__c | Outcome Metric | Number | e.g. trees planted, units donated |
| Outcome_Unit__c | Outcome Unit Label | Text(40) | e.g. "trees", "litres of blood" |
| Number_of_Volunteers__c | Volunteer Count | Roll-Up Summary (COUNT) | From `Campaign_Volunteer__c` |

### 2.7 Campaign_Volunteer__c (junction: Campaign ↔ Volunteer)

| Field API Name | Label | Type | Notes |
|---|---|---|---|
| Name | Assignment Number | Auto Number | Format: `CV-{00000}` |
| Campaign__c | Campaign | Master-Detail → Campaign__c | Required |
| Volunteer__c | Volunteer | Master-Detail → Volunteer__c | Required |
| Role__c | Role | Text(80) | e.g. "Team Lead", "Registration Desk" |
| Attendance_Status__c | Attendance | Picklist | Registered, Attended, No-show |
| Hours_Contributed__c | Hours Contributed | Number | Feeds volunteer-hours reporting |

---

## 3. Relationship Summary

- `Donor__c` **1:M** `Donation__c` (Master-Detail)
- `Campaign__c` **1:M** `Donation__c` (Lookup, optional)
- `Donation__c` **1:M** `Distribution__c` (Master-Detail)
- `Beneficiary__c` **1:M** `Distribution__c` (Master-Detail)
- `Campaign__c` **M:M** `Volunteer__c` via `Campaign_Volunteer__c` (both Master-Detail)

## 4. Automation Hooks to Carry Into the TDD

| Requirement | Suggested Mechanism |
|---|---|
| FR-08 — notify staff on large donation | Flow (record-triggered on `Donation__c`) → Email Alert when `Amount__c` > threshold |
| FR-08 — campaign reminders | Scheduled Flow, X days before `Campaign_Date__c` |
| BR-02 — auto status update | Apex trigger on `Distribution__c` (see 2.4) |
| BR-05 — volunteer count on campaign | Roll-Up Summary (native, no code) |
| Section 10 — role-based access | Sharing Rules + Field-Level Security per Section 9 matrix; Volunteers get read-only via Experience Cloud |
| Section 11 — mandatory field validation | Validation Rules on `Beneficiary__c` and `Donation__c` |

## 5. Open Questions for Sign-off

1. Should `Distribution__c` support splitting a single donation across **multiple** beneficiaries in one transaction, or is one distribution record always one beneficiary, one donation (current design)?
2. Do Outcome metrics need to be multi-valued per campaign (e.g., a food drive tracking both "meals served" and "families reached")? Current design assumes one metric + label per campaign — a child `Campaign_Outcome__c` object would be needed for multiple.
3. Should `Volunteer__c.User__c` be required at creation, or can volunteers exist in the system before they're granted Experience Cloud login?
