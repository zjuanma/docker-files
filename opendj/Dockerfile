FROM lusis/opendj

# Run with persist data
ADD opendjd.sh /etc/service/opendj/run

# Any custom schemas?
ADD 977-SGDS.ldif /var/lib/opendj/config/schema/977-SGDS.ldif
RUN chown opendj:opendj /var/lib/opendj/config/schema/977-SGDS.ldif

# Initialize data
ADD seed.ldif /var/lib/opendj/seed.ldif
#    /var/lib/opendj/bin/import-ldif --port 4444 --bindDN "cn=Directory Manager" --bindPassword ldappass --backendID userRoot --ldifFile /var/lib/opendj/seed.ldif --rejectFile rejected.ldif; \
