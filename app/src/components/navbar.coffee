import { Input } from "@material-tailwind/react"
import { IoIosSearch } from "react-icons/io"
import { Link } from "react-router-dom"

export Navbar = ->
  <nav className="bg-ctp-base p-4">
    <div className="container mx-auto flex justify-between items-center">
      <Link to="/">
        <div className="text-white font-bold text-2xl">LUFFY</div>
      </Link>
      <div className="container flex justify-end items-center">
        <Link to="/#schedule" className="text-white font-bold pr-10 hover:text-opacity-50 transition-all ease duration-200 hidden sm:block">Schedule</Link>
        <div className="w-72">
          <Input
            label="Search"
            icon={<IoIosSearch style={{ color: 'white' }} />}
            color="white"
          />
        </div>
      </div>
    </div>
  </nav>
