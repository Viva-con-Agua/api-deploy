create_email_address() {
    curl -X POST -H "Content-Type: application/json" -d @${1} http://localhost:1337/admin/email/email
}
create_email_job() {
    curl -X POST -H "Content-Type: application/json" -d @${1} http://localhost:1337/admin/email/job
}

init_email() {
    create_email_address ./dev/email/address.json &&
    create_email_job ./dev/email/register.default.json &&
    create_email_job ./dev/email/resetpw.default.json &&
    create_email_job ./dev/email/resetconfirm.default.json
}


init() {
    case $1 in
        email) init_email;;
        *)
    esac
}

create() {
    case $1 in
        email_address) create_email_address $2;;
        create_job) create_email_job $2;;
        *)
    esac
}

case $1 in
    init) init $2 $3 $4;;
    create) create $2 $3 $4;;
    *)
esac
