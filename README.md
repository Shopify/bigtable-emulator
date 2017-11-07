# Bigtable emulator Docker image

This repository contains the Google Cloud Bigtable emulator, which is an in memory Go impliementation of Bigtable allowing to create integration tests and local development. Warning: this is not a production tool.

The emulator is offered in the [Google Cloud SDK](https://cloud.google.com/bigtable/docs/emulator). However, this might be difficult or overkill to install the SDK locally on every development and CI box. In that case, this image provides a lightweight alternative (the image is around 17MB). It also provides an easy way to setup necessary tables and column families at startup.

To start it, run the following command:

```
docker run -it -p 9035:9035 shopify/bigtable-emulator
```

You can specify the tables and column families you need using the `-cf` switch. The format is a comma separated list of <instance>.<table>.<column family>. Ex:

```
docker run -it -p 9035:9035 shopify/bigtable-emulator -cf dev.records.data,dev.records.metadata
```

## Using it

You have to set the `BIGTABLE_EMULATOR_HOST` to the right docker host and container port. For example: `localhost:9035`. And then:

```go
import (
  "cloud.google.com/go/bigtable"
  "golang.org/x/net/context"
)

func NewDevBigTableClient() (*bigtable.Client, error) {
  ctx := context.Background()
  project := "dev"
  instance := "dev"
  return bigtable.NewClient(
    ctx, 
    project, 
    instance
  )
}

```

## License

This software is available under the MIT license (see 'LICENSE' file for more details).
