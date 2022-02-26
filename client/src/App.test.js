import App from "./App"
import { capitalise } from "./utils"
import renderer from "react-test-renderer"

describe("Helpers", () => {
  test("capitalises the movies endpoints", () => {
    expect(capitalise("cinema")).toBe("Cinema")
    expect(capitalise("CINEMA")).toBe("Cinema")
    expect(capitalise("cINEMA")).toBe("Cinema")
    expect(capitalise("cInEmA")).toBe("Cinema")
  })
})

test("App renders correctly", () => {
  const tree = renderer.create(<App />).toJSON()
  expect(tree).toMatchSnapshot()
})
