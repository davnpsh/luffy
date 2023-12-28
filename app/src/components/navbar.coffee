import { SearchResultsListSkeleton } from "./searchResultsList.coffee"
import { useState } from "react"
import { Input } from "@material-tailwind/react"
import { IoIosSearch } from "react-icons/io"
import { Link } from "react-router-dom"

export Navbar = ({ scheduleData, isScheduleLoading }) ->
  [input, setInput] = useState ""

  <nav className="bg-ctp-base p-4">
    <div className="container mx-auto flex justify-between items-center">
      <Link to="/">
        <div className="text-white font-bold text-2xl">LUFFY</div>
      </Link>
      <div className="container flex justify-end items-center">
        <Link
          to="/#schedule"
          className="text-white font-bold pr-10 hover:text-opacity-50 transition-all ease duration-200 hidden sm:block"
        >
          Schedule
        </Link>
        <div className="relative w-72">
          <Input
            label="Search"
            icon={<IoIosSearch style={color: "white"} />}
            color="white"
            onChange={(e) ->
              setInput e.target.value
              return
            }
          />
          {if input isnt ""
            if isScheduleLoading
              <SearchResultsListSkeleton/>
          }
        </div>
      </div>
    </div>
  </nav>
