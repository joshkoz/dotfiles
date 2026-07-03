return {
  cmd = { "tflint", "--langserver" },
  filetypes = { "terraform", "terraform-vars" },
  root_markers = { ".tflint.hcl", ".terraform", ".git" },
}
