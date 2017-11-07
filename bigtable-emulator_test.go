package main_test

import (
       "cloud.google.com/go/bigtable"
       "context"
       "github.com/stretchr/testify/suite"
       "google.golang.org/api/option"
       "golang.org/x/oauth2"
       "testing"
)

type testTokenSource struct{}

func (testTokenSource) Token() (*oauth2.Token, error) {
  return new(oauth2.Token), nil
}

type BigTableConnectivityTest struct {
       suite.Suite
}

func TestBigTableConnectivity(t *testing.T) {
       suite.Run(t, new(BigTableConnectivityTest))
}

func (assert *BigTableConnectivityTest) TestCanConnect() {
       ctx := context.Background()
       btClient, err := bigtable.NewAdminClient(ctx, "dev", "dev", option.WithTokenSource(&testTokenSource{}))
       assert.Nil(err)
       assert.NotNil(btClient)

       tables, err := btClient.Tables(ctx)
       assert.Nil(err)
       assert.NotNil(tables)

       btClient.Close()
}
