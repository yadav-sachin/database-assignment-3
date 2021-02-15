<h2 align = "center"> <b>ASSIGNMENT 3 : CS432 </b></h2>
<h1 align = "center">REPORT</h1>
<h4 align = "center"> Sachin Yadav 18110148 </h4>

# Ques 1.

# Ques 2.

- For a user to reference an attribute of another table as Foreign Key, it requires **references privilege** of that column in the given table, to which it want to refer.
- Here a user wants to create a table $r1$ which will refer to a column in $r2$. So this **user requires reference privilege on $r2$**.

Let's say our user is Sumit, who wants to create a table department_meetings (to keep track of the monthly meetings held by each department) and want to refer to dept_name column in departments table.
So he will ask the owner of the table to grant him, the permission using

```sql
GRANT REFERENCES (dept_name) ON departments TO Sumit;
```

**Why should this not be allowed simply without authorization**
- If a user references a column in a table as Foreign Key, it will restrict the delete and update operations in the referenced table.

- Let's say, one of my row refers to the $Computer\ Science\ and\  Engineering$ as dept_name. Now the user of the Departments table will not be able to delete this row without making changes to my table which references it as foreign key.
- Also if that user is updating a department name, it needs to be updated in my new table as well.
- Failing to update on my new table when deleting or updating in referenced table will cause inconsistency of data, which is not allowed due to the consistency constraint of foreign key.

- *If references was allowed without authorization*, then a user (malicious/by mistake) can easily hamper the update and delete privileges of another user owning those privileges on referenced table.

- To avoid any Public user to add such restrictions via foreign key, we have an explicit $references\ privilege$ authorisation for the user to authorise which users can refer to one of attributes in his relations.


# Ques 3.
| Consistency Constraints    | Authorization Constraints |
|:-------------:|:--------------:|
|1. These are the set of rules that makes sure that the changes made to the database by authorised users does not lead to loss of data quality/consistency.| 1. These are the set of permission that makes sure that only the authorised users with the valid privileges for the given operations are able to perform those operations (data retrieval, modification, deletion, etc.) to the database.|    
| 2. These prevent accidental damage to the consistency of the data in database. | 2. These prevent unauthorised access to the data and unauthorised changes to the data and database structure.|
|3. These are part of the database schema and are handled by the $Database\ Designers$. | 3. These are part of the user permissions and are handled by the $Database\ Administrator$|
|4. These integrity constraints can be classified into referential-integrity, domain, key and entity Integrity Constraints.| 4. Authorization can of form DELETE, EXECUTE, INSERT, SELECT, REFERENCES, TRIGGER and UPDATE.|
|5. Integrity Constraints are generally defined while designing/writing the schema of database. | 5. These are defined based on the user base and use of the database. Authorisations are generally defined after the schema declaration.  |
|6. We can use ALTER table to manage the integrity constraints after a relation has been created in database. | 6. We use GRANT/REVOKE statements (with options) to alter the authorization constraints.|
|7. Integrity Constraints are defined for attribute(s) in a single or multiple relation. | 7. Authorization Constraints are defined for users or a set of users/roles for a given set of operations.

<hr>    

**Examples Intergrity Constraints:**
- Two students cannot have same student_ID. [Key Constraint -- PRIMARY KEY]
- The age of a person should be greater or equal to 0. [Domain Constraint -- CHECK]
- An instructor cannot have a department name which does not exists in Departments table. [Referential-Integrity Constraint -- FOREIGN KEY]
- The name of a student cannot be NULL. [Entity-Integrity Constraint -- NOT NULL]
  

**Examples Authorization Constraints:**
- Only the users with role instructor have update privilege on the grade column in the student_grades relation.
- A student has only select (retrieving data) privilege on the student_grades relation.
- A user cannot refer to a table's attribute as foreign key without references privilege.
- A user cannot delete from table, without delete privilege.


# Ques 4.
## Part A

### Step 1. User A: grant select on T to B, C with grant option
   <img src="images/ques4_step1.png" alt="drawing" height="200" width="300"/>

### Step 2. User B: grant select on T to C
   <img src="images/ques4_step2.png" alt="drawing" height="200" width="300"/>

### Step 3. User C: grant select on T to D, E
<img src="images/ques4_step3.png" alt="drawing" height="200" width="300"/>

### Step 4. User A: grant select on T to E
<img src="images/ques4_step4.png" alt="drawing" height="200" width="300"/>

### Step 5. User A: revoke select on T from B restrict
<img src="images/ques4_step5.png" alt="drawing" height="200" width="300"/>     

### Step 6. User A: revoke select on T from C cascade
<img src="images/ques4_step6.png" alt="drawing" height="200" width="300"/>

### Explanation 
**In step 3**, D gets Select access to relation B (as C grants D the select privilege).
- **D gets select privilege.**

**In Step 5**, Here we are revoking privilege by restrict. Revoking the permission of B, will not affect the privilege of C (as it already have privilege directly from A). As revoking from B, does not have a cascading effect on C, so the command will be executed and B loses select privilege.
- **D still has select privilege.** As there is a path to from A to D via C.

**In Step 6**, as revoking here is by cascade and D was given select privilege by C. So revoking permission from C by Cascade, also revoked permission from D and E.
- **So D loses select privilege in step 6**. As there is no path from a to D now.
- E still has select privilege via A directly.

## Part B
<img src="images/ques4_step5.png" alt="drawing" height="200" width="300"/>
    
- At the end of Step 5, **C has select privilege with grant**.
- As the A (owner) has given C the select privilege directly with grant in Step 1, so C has the grant permission as well. 

- In Step 5, when owner revokes permission from B. Even though the permission was revoked from B via restrict; C was not affected as C had privilege via A already.
- The select privilege from B was an additional path from A to C via B, but the original direct path from A to C remains intact.
- There still is a path from A (owner) to C with grant permission.

- To summarise **C has select with grant privilege**.