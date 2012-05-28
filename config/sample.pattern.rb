# coding: utf-8

keyword /御早う|おはよ|起きた|おきた|オハヨ|ｵﾊﾖ|morning/i do
  "おはよう,御早う".split(',')
end

keyword /こんにちは|コンニチハ|ｺﾝﾆﾁﾊ/ do
  ["こんにちは"]
end

keyword /寝る|寝ます|おやす|night/i do
  "おやすみ,寝ろ".split(',')
end

keyword /(?:にゃーん|ニャーン|ﾆｬｰﾝ)+[!！]*$/ do
  ["猫か","寝ろ","？？？？？？？？"]
end
