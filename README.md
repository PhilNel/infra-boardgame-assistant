# Board Game Rules Assistant Infrastructure

This repository contains the Terraform infrastructure code for the Board Game Rules Assistant project. It manages AWS resources for storing game rules and running the rules assistant Lambda function.

## Related Repositories

- [`go-boardgame-assistant`](https://github.com/PhilNel/go-boardgame-assistant) - Collection of Lambdas used to process the knowledge base and provide an API to the Board Game Assistant project.

- [`knowledge-boardgame-assistant`](https://github.com/PhilNel/knowledge-boardgame-assistant) - Collection of structured board game rules in markdown format that forms the knowledge base for this project.

- [`pulumi-boardgame-assistant`](https://github.com/PhilNel/pulumi-boardgame-assistant) - Pulumi repository for adding references/citations used by knowledge base.

- [`vue-boardgame-assistant`](https://github.com/PhilNel/vue-boardgame-assistant) - The frontend Vue website that is used to interact with the Board Game Assistant functionality.