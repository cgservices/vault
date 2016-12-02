path "secret/*" {
  policy = "deny"
}

path "auth/token/lookup-self" {
  policy = "read"
}
