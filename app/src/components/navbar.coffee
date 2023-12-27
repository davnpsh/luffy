import { Input } from "@material-tailwind/react"
import { IoIosSearch } from "react-icons/io"

export Navbar = ->
  <nav className="bg-ctp-base p-4">
    <div className="container mx-auto flex justify-between items-center">
      <div className="text-white font-bold text-xl">luffy</div>
      <div>
        <div className="w-80">
          <Input
            label="Search"
            icon={<IoIosSearch style={{ color: 'white' }} />}
            color="white"
            className=""
            labelProps={
              className: "text-white"
            }
          />
        </div>
      </div>
    </div>
  </nav>
