import { render, screen } from "@testing-library/react"
import { Header } from "./Header"

describe("<Header/>", () => {
  test("renders the Prince's Theatre title", () => {
    render(<Header />)
    expect(screen.getByText("Prince's Theatre")).toBeInTheDocument()
  })
})
