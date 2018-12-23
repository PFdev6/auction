datenow = new Date
enddate = new Date(2018, 11, 23, 22, 10, 10)
info = ''
$ time = setInterval((->
  mnth = enddate.getMonth() - (new Date).getMonth()
  days = enddate.getDay() - (new Date).getDay()
  hrs = enddate.getHours() - (new Date).getHours()
  mn = enddate.getMinutes() - (new Date).getMinutes()
  sc = 60 - enddate.getSeconds() - (new Date).getSeconds()
  info = mnth + ':' + days + ':' + hrs + ':' + mn + ':' + sc
  $('#check').text info.toString()
  if mnth == 0 and days == 0 and hrs == 0 and mn == 0 and sc == 0
    clearInterval time
  return
), 1000)
