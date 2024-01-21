###
Anime Seasonals Web Scrapper
CREDITS: https://subsplease.org/

Released under GPLv2 license

DISCLAIMER:
    I am not related in any kind of form to Subsplease.
    Please, consider supporting them directly via seeding
    their torrents or not using this tool.
    This is just a project to learn about CoffeeScript.
###

import { log } from "./logger.coffee"
import puppeteer from "puppeteer"
import * as cheerio from "cheerio"

BASE_DOMAIN = "https://subsplease.org"

# 'domain' has to be a domain name
# 'query' has to be a JS function to evaluate in the browser
getData = (domain, queries) ->
  browser = await puppeteer.launch headless: "new", args: ["--no-sandbox"]
  page = await browser.newPage()

  await page.goto domain, waitUntil: "networkidle0", timeout: 0

  results = {}

  for key, query of queries
    try
      results[key] = await page.evaluate query
    catch
      log "error", "Error trying to evaluate query."
      results[key] = null

  await browser.close()

  return results

# Entire schedule, including:
#   - names
#   - pictures
#   - time
#   - links to more info
export getSchedule = ->
  queries =
    scheduleTable: -> document.getElementById("full-schedule-table").outerHTML

  try
    { scheduleTable } = await getData "#{BASE_DOMAIN}/schedule", queries
  catch
    log "error", "Error trying to fetch schedule from provider."
    return null

  # DOM
  $ = cheerio.load scheduleTable

  scheduleItems = {}
  currentDay = $ "tr:first"
    .find "h2"
    .text()

  $("tr").each (index, element) ->
    if $(element).attr("class") is "day-of-week"
      currentDay = $ element
        .find "h2"
        .text()
      return

    identifier = $ element
      .find "a"
      .attr "href"

    identifier = identifier.split("/")[-1..][0]

    # Data parsing
    show =
      name:
        $ element
          .find "a"
          .text()
      picture:
        $ element
          .find "a"
          .attr "data-preview-image"
      time:
        $ element
          .find ".all-schedule-time:first"
          .text()
      # Return only the show name embedded on the link
      identifier: identifier

    if !scheduleItems.hasOwnProperty currentDay
      scheduleItems[currentDay] = []

    scheduleItems[currentDay].push show

  log "answer", "Fetched schedule items from provider."
  return scheduleItems

# This receives the complete URL to a show
# Example: https://subsplease.org/shows/shy/
export getShowEpisodes = (showURL) ->
  showURL = "#{BASE_DOMAIN}/shows/#{showURL}"

  queries =
    episodesTable: -> document.getElementById("show-release-table").outerHTML

  try
    { episodesTable } = await getData showURL, queries
  catch
    log "error", "Error trying to fetch episodes links from provider."
    return null

  # DOM
  $ = cheerio.load episodesTable

  episodesList = {}

  $("tr").each (index, element) ->
    episodeNumberMatch = $ element
      .find ".episode-title:first"
      .text()
      .match(/—\s*(.+)/)[1]

    # Verify episode number
    if /^\d+$/.test episodeNumberMatch
      episodeNumber = episodeNumberMatch
    else
      # Episode number version control
      if /^\d+v\d+$/.test episodeNumberMatch
        episodeNumber = episodeNumberMatch.match(/(.+)v/)[1]
      else
        return

    episodeNumber = parseInt episodeNumber

    # Data parsing
    episodeLinks = {}

    $ element
      .find ".links"
      .each (index, element) ->
        magnetLink =
          "#{$(this).text()}":
            $ this
              .next "a"
              .attr "href"
        episodeLinks = { ...episodeLinks, ...magnetLink }

    episodesList[episodeNumber] = episodeLinks

  log "answer", "Fetched episodes links from provider."
  return episodesList

# Minimize load in schedule
export getShowProfile = (showURL) ->
  showURL = "#{BASE_DOMAIN}/shows/#{showURL}"

  queries =
    showName: -> document.querySelector("h1").textContent
    episodesTable: -> document.getElementById("show-release-table").outerHTML

  try
    { showName, episodesTable } = await getData showURL, queries
  catch
    log "error", "Error trying to fetch show name and release year."
    return null

  # DOM
  $ = cheerio.load episodesTable

  millenium = new Date().getFullYear().toString()[0..1]
  decade = $ "tr:last"
    .find ".release-item-time:first"
    .find "span:first"
    .text()[-2..]

  showYear = millenium + decade

  log "answer", "Fetched show name and release year from provider."
  return name: showName, year: showYear
