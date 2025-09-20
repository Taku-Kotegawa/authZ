# TODO List for Project Initialization

This list is based on `構築手順.md`.

- [ ] Create `pom.xml` with the specified dependencies.
- [ ] Create `docker-compose.yml` for the PostgreSQL database.
- [ ] Create `src/main/resources/schema.sql` with the database schema.
- [ ] Create `src/main/resources/application.yml` with the application configuration.
- [ ] Create the main application class `src/main/java/com/example/internalauthzserver/InternalAuthzServerApplication.java`.
- [ ] Create `src/main/java/com/example/internalauthzserver/config/SecurityConfig.java`.
- [ ] Create `src/main/resources/data.sql` for initial data seeding.
- [ ] Create DTO classes:
    - [ ] `src/main/java/com/example/internalauthzserver/dto/LoginRequest.java`
    - [ ] `src/main/java/com/example/internalauthzserver/dto/LoginResponse.java`
    - [ ] `src/main/java/com/example/internalauthzserver/dto/UserResponse.java`
- [ ] Create Controller classes:
    - [ ] `src/main/java/com/example/internalauthzserver/controller/ResourceController.java`
    - [ ] `src/main/java/com/example/internalauthzserver/controller/AdminController.java`
- [ ] Create `Dockerfile` for building the application image.
- [ ] Update `docker-compose.yml` to include the application service.

**Tasks that cannot be performed:**

*   Running `docker-compose` or `docker` commands.
*   Performing manual operation checks.
