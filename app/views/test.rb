require 'date'

wdays = ['(日)','(月)','(火)','(水)','(木)','(金)','(土)']
day = Date.today.wday
wdays[day]