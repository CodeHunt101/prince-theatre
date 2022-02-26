export const capitalise = (string) => (
  string[0].toUpperCase() + string.slice(1).toLowerCase()
)

export const handleErrors = (response) => {
  if (!response.ok) {
      throw Error(response.statusText);
  }
  return response;
}