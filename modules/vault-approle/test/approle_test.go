/*
Test Case:
  - confirm approle auth method was mounted
  - generate secret id
  - generate token

Test Type: Unit Test
*/

package test

import (
	// "context"
	"fmt"
	"os"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/hashicorp/vault/api"
	// "github.com/hashicorp/vault/api/auth/approle"

	"github.com/palantir/stacktrace"
	"github.com/stretchr/testify/assert"
)

func TestApprole(t *testing.T) {

	// Construct the terraform options with default retryable errors to handle the most common
	// retryable errors in terraform testing.
	// terraform.Options is a struct
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{

		// Set the path to the Terraform code that will be tested.
		TerraformDir: "../",
	})

	// Clean up resources with "terraform destroy" at the end of the test.
	defer terraform.Destroy(t, terraformOptions)

	// Run "terraform init" and "terraform apply". Fail the test if there are any errors.
	terraform.InitAndApply(t, terraformOptions)

	// // terrform output
	// expectedRoleData := terraform.OutputMap(t, terraformOptions, "role_id")

	/*
	 construct approle path: in the data structure, all auth methods in sys/auths have a "/". for example: mount path is "approle/"
	*/
	expectedApprolePath := "app-demo"
	approlePath := expectedApprolePath + "/"

	// VAULT CLIENT
	config := api.DefaultConfig()        // returns default configuration of the vault client
	client, err := api.NewClient(config) // create and returns a vault client
	// error handling
	if err != nil {

		err = stacktrace.Propagate(err, "initialization error. Could not setup client with default config")
		fmt.Println(err)
		os.Exit(1)

	}

	/*
		Exexute Test Cases
	*/

	// store state of approle mount
	approleExist, _ := isApproleMounted(client, approlePath)
	// assert approle was enabled
	assert.True(t, approleExist, "approle doesn't exist")

	// // extract role-name and role-id
	// roleName, roleID := extractRoleID(expectedRoleData)

	// var secretID string // secret id for generating approle token

	// if roleName == "" {

	// 	t.Error("empty string")

	// } else {

	// 	// generate secret-id
	// 	secretID = createSecretID(client, approlePath, roleName)

	// }

	// if roleID == "" {

	// 	t.Error("empty string")

	// } else {

	// 	// generate token
	// 	token := generateToken(client, expectedApprolePath, roleID, secretID)

	// 	if token == "" {
	// 		t.Error("no token was generated")
	// 	}

	// }

}

// function returns data about the approle and the boolean state of the approle mount
func isApproleMounted(c *api.Client, approlePath string) (bool, *api.MountOutput) {

	// mountData contains information about the mounted auth method
	var mountData *api.MountOutput

	// returns all enabled auth methods
	auths, err := c.Sys().ListAuth()
	if err != nil {

		err = stacktrace.Propagate(err, "Could not find any auth method")
		fmt.Println(err)
		os.Exit(1)

	}

	// traverse the returned auth methods
	for auth, mountData := range auths {

		if auth == approlePath {

			return true, mountData

		}

	}

	return false, mountData

}
