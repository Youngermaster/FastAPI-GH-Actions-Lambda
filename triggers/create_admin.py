import requests
import json

url = "https://0e6ooouu61.execute-api.us-east-1.amazonaws.com/prod/transport-app"

# GraphQL mutation
mutation = """
mutation CreateAdmin {
  createAdmin(createAdminData: {
    firstName: "Admin1",
    lastName: "Apellido1",
    email: "admin1@example.com",
    password: "123456",
    phoneNumber: "3000000000"
  }) {
    token
    admin {
      id
      firstName
      lastName
      email
      phoneNumber
    }
  }
}
"""

# Headers and payload
headers = {
    "Content-Type": "application/json"
}
payload = {
    "query": mutation
}

# Sending POST request to the GraphQL endpoint
response = requests.post(url, headers=headers, json=payload)

# Parsing the response
if response.status_code == 200:
    print("Success:")
    print(response.json())
else:
    print("Error:")
    print("Status Code:", response.status_code)
    print("Response:", response.text)

