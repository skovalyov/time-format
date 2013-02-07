## Public API
module.exports =

  # <code>span()</code> formats the time span between now and the date specified in a "Facebook way".
  # 
  # Examples:
  # 
  #     May 18, 2011 at 5:11AM
  #     December 25 at 8:43PM
  #     Friday at 3:53PM
  #     Tomorrow at 10:44AM
  #     In 10 hours
  #     In about an hour
  #     In 25 minutes
  #     In about a minute
  #     In 17 seconds
  #     In a few seconds
  #     A few seconds ago
  #     31 seconds ago
  #     About a minute ago
  #     47 minutes ago
  #     About an hour ago
  #     4 hours ago
  #     Yesterday at 6:25PM
  span : (date, now = new Date()) ->
    range = (now.getTime() - date.getTime()) / MILLISECONDS_IN_SECOND
    nextYearStart = new Date now.getFullYear() + 1, 0, 1
    nextWeekStart = new Date now.getFullYear(), now.getMonth(), now.getDate() + (7 - now.getDay())
    tomorrowStart = new Date now.getFullYear(), now.getMonth(), now.getDate() + 1
    theDayAfterTomorrowStart = new Date now.getFullYear(), now.getMonth(), now.getDate() + 2
    todayStart = new Date now.getFullYear(), now.getMonth(), now.getDate()
    yesterdayStart = new Date now.getFullYear(), now.getMonth(), now.getDate() - 1
    thisWeekStart = new Date now.getFullYear(), now.getMonth(), now.getDate() - now.getDay()
    thisYearStart = new Date now.getFullYear(), 0, 1
    nextYearRange = (now.getTime() - nextYearStart.getTime()) / MILLISECONDS_IN_SECOND
    nextWeekRange = (now.getTime() - nextWeekStart.getTime()) / MILLISECONDS_IN_SECOND
    theDayAfterTomorrowRange = (now.getTime() - theDayAfterTomorrowStart.getTime()) / MILLISECONDS_IN_SECOND
    tomorrowRange = (now.getTime() - tomorrowStart.getTime()) / MILLISECONDS_IN_SECOND
    todayRange = (now.getTime() - todayStart.getTime()) / MILLISECONDS_IN_SECOND
    yesterdayRange = (now.getTime() - yesterdayStart.getTime()) / MILLISECONDS_IN_SECOND
    thisWeekRange = (now.getTime() - thisWeekStart.getTime()) / MILLISECONDS_IN_SECOND
    thisYearRange = (now.getTime() - thisYearStart.getTime()) / MILLISECONDS_IN_SECOND
    if range >= 0
      if range < FEW_SECONDS
        result = "A few seconds ago"
      else if range < SECONDS_IN_MINUTE
        result = "#{Math.floor(range)} seconds ago"
      else if range < SECONDS_IN_MINUTE * 2
        result = "About a minute ago"
      else if range < SECONDS_IN_HOUR
        result = "#{Math.floor(range / SECONDS_IN_MINUTE)} minutes ago"
      else if range < SECONDS_IN_HOUR * 2
        result = "About an hour ago"
      else if range < todayRange
        result = "#{Math.floor(range / SECONDS_IN_HOUR)} hours ago"
      else if range < yesterdayRange
        result = "Yesterday at #{formatTime(date)}"
      else if range < thisWeekRange
        result = "#{formatWeekday(date)} at #{formatTime(date)}"
      else if range < thisYearRange
        result = "#{formatMonth(date)} #{date.getDate()} at #{formatTime(date)}"
      else
        result = "#{formatMonth(date)} #{date.getDate()}, #{date.getFullYear()} at #{formatTime(date)}"
    else
      if range > - FEW_SECONDS
        result = "In a few seconds"
      else if range > - SECONDS_IN_MINUTE
        result = "In #{Math.floor(-range)} seconds"
      else if range > - SECONDS_IN_MINUTE * 2
        result = "In about a minute"
      else if range > - SECONDS_IN_HOUR
        result = "In #{Math.floor(-range / SECONDS_IN_MINUTE)} minutes"
      else if range > - SECONDS_IN_HOUR * 2
        result = "In about an hour"
      else if range > tomorrowRange
        result = "In #{Math.floor(-range / SECONDS_IN_HOUR)} hours"
      else if range > theDayAfterTomorrowRange
        result = "Tomorrow at #{formatTime(date)}"
      else if range > nextWeekRange
        result = "#{formatWeekday(date)} at #{formatTime(date)}"
      else if range > nextYearRange
        result = "#{formatMonth(date)} #{date.getDate()} at #{formatTime(date)}"
      else
        result = "#{formatMonth(date)} #{date.getDate()}, #{date.getFullYear()} at #{formatTime(date)}"
    return result

## Private API

# Constants.
FEW_SECONDS = 5
MILLISECONDS_IN_SECOND = 1000
SECONDS_IN_MINUTE = 60
SECONDS_IN_HOUR = SECONDS_IN_MINUTE * 60
MONTH_NAMES = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
WEEKDAY_NAMES = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]

# Format time part of the Date object.
formatTime = (date) ->
  minutes = date.getMinutes()
  hours = date.getHours()
  ampm = if hours > 12 then "pm" else "am"
  formattedHours = if hours == 0 or hours == 12 then "12" else "#{hours % 12}";
  formattedMinutes = if minutes < 10 then "0#{minutes}" else "#{minutes}"
  return "#{formattedHours}:#{formattedMinutes}#{ampm}"

# Get month name of the Date object.
formatMonth = (date) -> MONTH_NAMES[date.getMonth()]

# Get weekday name of the Date object.
formatWeekday = (date) -> WEEKDAY_NAMES[date.getDay()]
