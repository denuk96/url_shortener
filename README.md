## Simple Link Minimization Service

### Overview
Implement a simple service for link minimization.

### Features
- **REST API**:
    - Create shortened links.
    - View statistics on link visits.
- **Unique Links**: All links must be unique and not duplicated.
- **Redirection**: Redirect users to the full link when they access the shortened version.
- **Admin Panel**:
    - Display a list of all generated links and their visit counts.
    - Allow deletion of shortened links.
    - Simple authorization using basic_auth.
- **Public REST API Methods**:
    - Create links.
    - View statistics.
    - Delete links.
- **Link Management**: Editing and deleting a link (by the user through the REST API) should be done using a password generated at the time of link creation.

### Additional Features (Plus Points)
- **Pagination**: Implement pagination in the admin panel.
- **Auto-Deletion**: Implement a feature to delete links with no visits for more than two months (could be a button in the admin panel).
- **Search Functionality**: Implement search in the admin panel.

### How to run it? 
```bash
  docker-compose build
  docuer-compose up
```
