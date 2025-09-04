# Board Game Rules Assistant Infrastructure

This repository contains the Terraform infrastructure code for the Board Game Rules Assistant project. It manages AWS resources for storing game rules and running the rules assistant Lambda function.

## Related Repositories

- [`go-boardgame-assistant`](https://github.com/PhilNel/go-boardgame-assistant) - Collection of Lambdas used to process the knowledge base and provide an API to the Board Game Assistant project.

- [`infra-boardgame-assistant`](https://github.com/PhilNel/infra-boardgame-assistant) - Terraform configuration for deploying the infrastructure and managing Lambda permissions, S3 buckets, etc.

- [`pulumi-boardgame-assistant`](https://github.com/PhilNel/pulumi-boardgame-assistant) - Pulumi repository for adding references/citations used by by knowledge base.

- [`vue-boardgame-assistant`](https://github.com/PhilNel/vue-boardgame-assistant) - The frontend Vue website that is used to interact with the Board Game Assistant functionality.