export log = (type, message) ->

    currentDateTime = new Date

    formattedDateTime = new Intl.DateTimeFormat 'en-US',
        year: "numeric"
        month: "short"
        day: "2-digit"
        hour: "2-digit"
        minute: "2-digit"
        second: "2-digit"
        timeZoneName: "short"
    .format currentDateTime

    console.log "[#{formattedDateTime}] API #{type}: #{message}"