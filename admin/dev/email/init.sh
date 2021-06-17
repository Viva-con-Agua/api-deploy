#!/bin/bash

create() {
    curl -X POST -H "Content-Type: application/json" -d @address.json http://localhost:1337/admin/email/email
    #curl -X POST -H "Content-Type: application/json" -d @participation.default.json http://localhost:1337/admin/email/job
}

create

