#!/bin/bash

create_address() {
    curl -X POST -H "Content-Type: application/json" -d @${1} http://localhost:1337/admin/email/email
}
create_job() {
    curl -X POST -H "Content-Type: application/json" -d @${1} http://localhost:1337/admin/email/job
}

create_address address.json &&
create_job register.default.json &&
create_job resetpw.default.json &&
create_job resetconfirm.default.json

