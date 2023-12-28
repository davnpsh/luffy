import {
  SearchResultsList
  SearchResultsListSkeleton
} from "./searchResultsList.coffee"
import { useState } from "react"
import { Input } from "@material-tailwind/react"
import { IoIosSearch } from "react-icons/io"
import { Link } from "react-router-dom"

export Navbar = ({ scheduleData, isScheduleLoading }) ->
  [input, setInput] = useState ""
  [filteredResults, setFilteredResults] = useState {}

  handleInputChange = (value) ->
    setInput value

    if !isScheduleLoading
      filteredData = {}

      Object.keys(scheduleData).forEach (day) ->
        filteredData[day] = scheduleData[day].filter (item) ->
          item.name.toLowerCase().includes input.toLowerCase()

      setFilteredResults filteredData

  clearInput = ->
    setInput ""

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
            value={input}
            onChange={(e) ->
              handleInputChange e.target.value
              return
            }
          />
          {if input isnt ""
            if isScheduleLoading
              <SearchResultsListSkeleton />
            else
              <SearchResultsList
                filteredResults={filteredResults}
                clearInput={clearInput}
              />
          }
        </div>
      </div>
    </div>
  </nav>
