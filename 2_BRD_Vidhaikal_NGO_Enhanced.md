**Business Requirements Document**

**Vidhaikal NGO Management System**

_Salesforce Implementation - Donor, Donation, Beneficiary, Volunteer & Campaign Management_

# **1\. Project Name**

**Vidhaikal NGO Management System**

A Salesforce-based system to help Vidhaikal NGO manage donors, donations, beneficiaries, volunteers, campaigns, and reporting.

# **2\. Document Summary**

Vidhaikal is a non-profit organization that supports underprivileged communities by collecting and distributing donations (food, clothing, school supplies, and financial aid), and by running educational and environmental campaigns. This system will digitize these operations end-to-end on the Salesforce platform to improve efficiency, accuracy, and transparency.

## **Document Control**

| **Field**        | **Details**                                         |
| ---------------- | --------------------------------------------------- |
| Document Version | 1.1 (Enhanced)                                      |
| Prepared By      | Business Analyst                                    |
| Reviewed By      | \_**\_**\_**\_**\_**\_**\_\_ Date: \_**\_**\_\_\_\_ |
| Approved By      | \_**\_**\_**\_**\_**\_**\_\_ Date: \_**\_**\_\_\_\_ |
| Status           | Draft - Pending Review                              |

## **Distribution**

| **Name**         | **Title**     | **Department**   |
| ---------------- | ------------- | ---------------- |
| \_**\_**\_**\_** | Product Owner | \_**\_**\_**\_** |
| \_**\_**\_**\_** | Scrum Master  | \_**\_**\_**\_** |
| \_**\_**\_**\_** | NGO Manager   | \_**\_**\_**\_** |

# **3\. Purpose**

The purpose of this project is to build a single system that allows Vidhaikal NGO to:

- Manage Donors - store donor name, address, phone, email, and donation history.
- Manage Donations - track money, food, clothes, books, and school supplies, including who gave, what was given, and when.
- Track Beneficiaries - maintain records of people who received aid, and what they received.
- Organize Campaigns - manage events such as tree plantation, blood donation, and food distribution drives.
- Generate Reports - produce donation, beneficiary, volunteer, and campaign reports to support transparency and decision-making.

# **4\. Project Scope**

## **4.1 In Scope**

| **Feature**            | **Description**                                                   |
| ---------------------- | ----------------------------------------------------------------- |
| Donor Management       | Create, update, and maintain donor records and donation history.  |
| Donation Tracking      | Record and track all donation types and their status.             |
| Beneficiary Management | Maintain beneficiary information and aid distribution history.    |
| Volunteer Management   | Register volunteers, assign them to events, and track attendance. |
| Campaign Management    | Create and manage NGO events and track outcomes.                  |
| Reports & Dashboards   | Generate reports and dashboards for management.                   |
| Notifications          | Send email alerts and reminders to staff and volunteers.          |

## **4.2 Out of Scope**

| **Feature**            | **Clarification**                                                                                                                                                                                                                        |
| ---------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Online Payment Gateway | No integration with UPI, Razorpay, Stripe, or credit card processing. Money donations are recorded manually as data entries, not collected online.                                                                                       |
| Accounting / Payroll   | The system records that a monetary donation was received; it does not perform financial reconciliation, ledger accounting, salary, or payroll processing. Any accounting of funds remains with the NGO's existing finance process/tools. |

# **5\. Stakeholders**

| **Stakeholder**        | **Responsibility**                                                       |
| ---------------------- | ------------------------------------------------------------------------ |
| NGO Management         | Reviews reports, approves budget, oversees overall program direction.    |
| Staff Members          | Enter and maintain donor, donation, and beneficiary records.             |
| Volunteers             | Participate in campaigns, update attendance, view assigned tasks.        |
| Volunteer Coordinators | Assign volunteers to events and track participation.                     |
| Donors                 | Contribute donations; may view acknowledgement/history where applicable. |
| Beneficiaries          | Receive aid distributed by the NGO.                                      |
| Salesforce Developers  | Build and configure custom objects, automation, and reports.             |
| System Administrators  | Manage user access, security, and system maintenance.                    |

# **6\. Business Requirements**

## **BR-01: Donor Management**

The system shall store donor details, maintain donation history per donor, and generate donor-level reports.

## **BR-02: Donation Management**

The system shall record donations across all types (money, food, clothes, school supplies) and track donation date, quantity, and status (Received / Distributed / Pending).

## **BR-03: Beneficiary Management**

The system shall store beneficiary name, address, family details, and items received, and maintain a complete distribution history.

## **BR-04: Volunteer Management**

The system shall store volunteer information, allow assignment to activities (food distribution, medical camps, tree plantation), and track attendance.

## **BR-05: Campaign Management**

The system shall allow creation of campaigns with name, date, and location, and track metrics such as number of volunteers and outcomes (e.g., trees planted).

## **BR-06: Reporting & Notifications**

The system shall generate dashboards/reports for donations, beneficiaries, volunteers, and campaigns, and send automated email notifications/reminders to staff and volunteers.

# **7\. Functional Requirements**

| **ID** | **Requirement**               | **Description**                                                                                   |
| ------ | ----------------------------- | ------------------------------------------------------------------------------------------------- |
| FR-01  | Create and Manage Donors      | Add, update, and deactivate donor records.                                                        |
| FR-02  | Record Donations              | Capture donation type, date, quantity, and status for every donation.                             |
| FR-03  | Create Beneficiary Records    | Maintain beneficiary profile and history of aid received.                                         |
| FR-04  | Register Volunteers           | Capture volunteer contact details, skills, and availability.                                      |
| FR-05  | Assign Volunteers to Events   | Link volunteers to specific campaigns/activities and track attendance.                            |
| FR-06  | Manage Campaigns              | Create, update, and close out campaigns with outcome tracking.                                    |
| FR-07  | Generate Reports & Dashboards | Produce donation, beneficiary, volunteer, and campaign reports.                                   |
| FR-08  | Send Notifications            | Trigger email alerts/reminders for key events (e.g., large donation received, upcoming campaign). |

_Note: FR-04 (Register Volunteers) and FR-08 (Send Notifications) have been added to align the Functional Requirements with the features already listed as In-Scope in Section 4.1._

# **8\. Traceability Matrix**

Maps each Business Requirement to the Functional Requirement(s) that satisfy it, to ensure no scope item is missed during design or testing.

| **Business Requirement**         | **Related Functional Requirement(s)** |
| -------------------------------- | ------------------------------------- |
| BR-01: Donor Management          | FR-01, FR-07                          |
| BR-02: Donation Management       | FR-02, FR-07                          |
| BR-03: Beneficiary Management    | FR-03, FR-07                          |
| BR-04: Volunteer Management      | FR-04, FR-05                          |
| BR-05: Campaign Management       | FR-06, FR-05                          |
| BR-06: Reporting & Notifications | FR-07, FR-08                          |

# **9\. Roles & Permissions**

| **Role**                                | **Donor / Donation**  | **Beneficiary** | **Volunteer / Campaign** | **Reports**       |
| --------------------------------------- | --------------------- | --------------- | ------------------------ | ----------------- |
| System Administrator                    | Full Access           | Full Access     | Full Access              | Full Access       |
| NGO Manager / Staff                     | Create/Edit           | Create/Edit     | Create/Edit              | View/Export       |
| Volunteer Coordinator                   | View Only             | View Only       | Create/Edit (own events) | View (own events) |
| Volunteer                               | No Access             | No Access       | View assigned tasks only | No Access         |
| Donor (if portal access is added later) | View own records only | No Access       | No Access                | No Access         |

# **10\. Non-Functional Requirements**

| **Category**       | **Requirement**                                                     | **Acceptance Criteria**                                                                                       |
| ------------------ | ------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------- |
| Security           | Only authorized users can access records appropriate to their role. | Admin can edit all records; Volunteer can only view assigned tasks; unauthorized access attempts are blocked. |
| Multi-user Support | Multiple users can work on the system simultaneously.               | At least 10 staff members can create/update records concurrently without data conflicts.                      |
| Performance        | Reports and dashboards load quickly.                                | A donation report with standard data volume loads within 5 seconds.                                           |
| Backup             | System data is protected against loss.                              | Automatic daily backups are configured and verified weekly.                                                   |

# **11\. Assumptions and Risks**

## **Assumptions**

- Internet connectivity is available at NGO offices and event locations.
- Staff and volunteers will be trained on the new system before go-live.
- Existing donor and beneficiary data is available for migration.
- All users have valid Salesforce login credentials (or Experience Cloud access for volunteers).

## **Risks**

| **Risk**                          | **Impact**                                   | **Mitigation**                                                    |
| --------------------------------- | -------------------------------------------- | ----------------------------------------------------------------- |
| Incorrect beneficiary information | Wrong aid distribution                       | Mandatory field validation and periodic data review.              |
| Delay in donation data entry      | Inaccurate/late reporting                    | Set data-entry SLAs and automated reminder notifications (FR-08). |
| Low volunteer participation       | Event under-staffing                         | Early volunteer registration drives and reminder notifications.   |
| Data security issues              | Exposure of sensitive donor/beneficiary data | Role-based access control (Section 9) and regular access audits.  |

# **12\. Budget (Estimated)**

| **Item**                     | **Description**                                 | **Estimated Cost (INR)** |
| ---------------------------- | ----------------------------------------------- | ------------------------ |
| Salesforce Licenses          | User licenses for Admin and Staff               | ₹1,20,000/year           |
| Development Cost             | Custom objects, automation, reports, dashboards | ₹2,50,000                |
| Testing & UAT                | System testing and user acceptance testing      | ₹30,000                  |
| Data Migration               | Import donor and beneficiary data               | ₹20,000                  |
| User Training                | Train NGO staff and volunteers                  | ₹25,000                  |
| Deployment & Go-Live Support | Production deployment and post-launch support   | ₹25,000                  |
| Annual Maintenance           | Bug fixes and enhancements                      | ₹50,000/year             |

## **Recommended Salesforce Licensing**

| **User Type**             | **Recommended License**                                | **Why**                                                                                                                         |
| ------------------------- | ------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------- |
| System Administrator      | Salesforce System Administrator (Enterprise/Unlimited) | Full configuration, automation, security, and user management.                                                                  |
| Staff managing volunteers | Platform or full Salesforce license                    | Platform is sufficient for custom apps/objects; full license needed if using Leads, Opportunities, Cases, etc.                  |
| Volunteer Coordinators    | Platform or full Salesforce                            | Depends on whether CRM features beyond volunteer management are needed.                                                         |
| Volunteers                | Experience Cloud login-based license                   | Lets volunteers log in, view schedules, update profiles, register for shifts, and submit hours without a full internal license. |

# **13\. Success Criteria**

- 100% donation tracking - every donation is recorded and traceable.
- Accurate beneficiary records - information is complete and kept up to date.
- Faster report generation - reports support timely decision-making (see Section 10 performance target).
- Improved transparency and accountability - donors and management can clearly see how funds/goods are received and distributed.