FROM rethinkdb:latest
COPY docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

# checking for empty command in entrypoint.sh to allow runtime override
CMD [""]
