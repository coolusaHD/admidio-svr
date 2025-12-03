# Age Constraints and Mutually Exclusive Groups Feature

This feature adds the ability to set age constraints and mutually exclusive groups for roles in Admidio.

## Age Constraints

### Overview
Administrators can now define age restrictions for roles to ensure that only members who meet specific age criteria can be assigned to a role.

### Configuration
In the role edit form, you'll find a new field called "Age constraint". You can set constraints using the following formats:

- **Exact age**: `18` (only members exactly 18 years old)
- **Less than**: `<18` (members younger than 18)
- **Less than or equal**: `<=18` (members 18 or younger)
- **Greater than**: `>18` (members older than 18)
- **Greater than or equal**: `>=18` (members 18 or older)
- **Age range**: `18-25` (members between 18 and 25 years old, inclusive)

### Validation
When an age constraint is set:
1. The system automatically validates new member assignments against the constraint
2. Users who don't meet the age requirement will not be able to join the role
3. An error message will be displayed explaining why the assignment failed

### Checking Existing Members
A "Check age constraint" button appears on roles that have age constraints. Clicking this button:
1. Scans all current members of the role
2. Displays a list of members who don't meet the age constraint
3. Provides direct links to member profiles for easy reassignment

## Mutually Exclusive Groups

### Overview
Mutually exclusive groups prevent users from being members of multiple roles within the same group simultaneously. This is especially useful for membership fee roles where a member should only be in one fee category at a time.

### Configuration
In the role edit form, you'll find a new field called "Mutually exclusive group". Enter a group name (e.g., "membership_fees") to mark this role as part of a mutually exclusive group.

All roles with the same group name will be mutually exclusive, meaning:
- A member can only be in ONE role from that group at any time
- Attempting to assign a member to a second role in the same group will be blocked
- An error message will indicate which role the member is already assigned to

### Use Cases
- **Membership Fees**: Create roles like "Student Fee", "Regular Fee", "Senior Fee" all in the "membership_fees" group
- **Team Assignments**: Prevent members from being on multiple competing teams
- **Access Levels**: Ensure members have only one access level (Basic, Premium, VIP)

## Database Schema Changes

Two new fields were added to the `adm_roles` table:
- `rol_age_constraint` (varchar(100)): Stores the age constraint expression
- `rol_mutually_exclusive_group` (varchar(100)): Stores the mutually exclusive group name

An update migration file (`update_5_1.xml`) has been created for existing installations.

## Language Strings

The following new language strings were added to support this feature:
- `SYS_AGE_CONSTRAINT`
- `SYS_AGE_CONSTRAINT_DESC`
- `SYS_CHECK_AGE_CONSTRAINT`
- `SYS_MEMBERS_NOT_MEETING_CONSTRAINT`
- `SYS_ALL_MEMBERS_MEET_CONSTRAINT`
- `SYS_MUTUALLY_EXCLUSIVE_GROUP`
- `SYS_MUTUALLY_EXCLUSIVE_GROUP_DESC`
- `SYS_USER_NOT_MEETING_AGE_CONSTRAINT`
- `SYS_USER_ALREADY_IN_EXCLUSIVE_GROUP`

## Implementation Details

### Files Modified
- `install/db_scripts/db.sql` - Added new database fields
- `install/db_scripts/update_5_1.xml` - Migration script for existing installations
- `src/Roles/Entity/Role.php` - Added validation methods
- `src/UI/Presenter/GroupsRolesPresenter.php` - Added UI elements and check dialog
- `modules/groups-roles/groups_roles.php` - Added check_members mode
- `modules/groups-roles/members_assignment.php` - Added validation on member assignment
- `themes/simple/templates/modules/groups-roles.check-members.tpl` - Check members dialog template
- `languages/en.xml` - Added language strings

### Key Methods
- `Role::userMeetsAgeConstraint(User $user)` - Validates if a user meets the age constraint
- `Role::getMembersViolatingAgeConstraint()` - Returns list of members not meeting constraint
- `Role::userHasMutuallyExclusiveMembership(int $userId)` - Checks for conflicting memberships
- `GroupsRolesPresenter::createCheckMembersDialog(Role $role, array $violatingMembers)` - Creates the validation dialog UI
