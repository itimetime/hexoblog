---
title: appium相关API整理
date: 2020-05-10 22:04:26
tags: Appium
---

### Appium API

整理的一些Appium的一些Api，只是整理，内容收集于网上，非原创。

#### 简略版

```python
# 元素定位
driver.find_element_by_id("id")   # id定位
driver.find_element_by_name("name")  # name定位
driver.find_element_by_link_text("text")  # 链接名定位
driver.find_element_by_partial_link_text("text")  # 通过元素部分可见链接文本定位
driver.find_element_by_tag_name("name")  # 通过查找html的标签名称定位元素
driver.find_element_by_xpath("xpath")  # 路径定位
driver.find_element_by_class_name("android.widget.LinearLayout")  # 类名定位
driver.find_element_by_css_selector("css") # css选择器定位

# 元素集合复数定位
driver.find_elements_by_id("id")  # id元素集合
driver.find_elements_by_name("name") # name元素集合
driver.find_elements_by_link_text("text") # 链接名元素集合
driver.find_elements_by_partial_link_text("text") # 部分元素可见链接集合
driver.find_elements_by_tag_name("name")  # html标签名集合
driver.find_elements_by_xpath("xpath")  # 路径定位集合
driver.find_elements_by_class_name("android.widget.LinearLayout")  # 类名定位集合
driver.find_elements_by_css_selector("css") # css选择器定位集合

# 输入框输入
driver.element.send_keys("中英")

# 锁定屏幕
driver.lock(5)

# 把当前应用置于后台
driver.background_app(5)

# 收起键盘
driver.hide_keyboard()

# 打开一个应用或者activity，仅安卓端
driver.start_activity('com.example.android.apis', '.Foo')

# 打开下拉通知栏 仅Android
driver.open_notifications()

# 拖动元素，将元素origin_el拖到目标元素destination_el
driver.drag_and_drop(self, origin_el, destination_el):

# 检查app是否已安装
driver.is_app_installed('com.example.android.apis')

# 安装应用到设备
driver.install_app('path/to/my.apk')

# 删除应用
driver.remove_app('com.example.android.apis')

# 模拟设备摇晃
driver.shake()


# 关闭应用
driver.close_app()

# 启动 (Launch)
# 根据服务关键字 (desired capabilities) 启动会话 (session) 。请注意这必须在设定 autoLaunch=false 关键字时才能生效。
# 这不是用于启动指定的 app/activities ————你可以使用 start_activity 做到这个效果————
# 这是用来继续进行使用了 autoLaunch=false 关键字时的初始化 (Launch) 流程的。
driver.launch_app()

# 应用重置，相当于重新卸载安装
driver.reset()

# 可用上下文 (context) 列出所有的可用上下文
# 翻译备注：context可以理解为 可进入的窗口 。例如，对于原生应用，可用的context和默认context均为NATIVE_APP。
# 详情可查看对混合应用进行自动化测试
driver.contexts

# 列出当前上下文
driver.current_context

# 切换到默认的上下文 (context)
# 将上下文切换到默认上下文
driver.switch_to.context(None)

# 获取应用的字符串
driver.app_strings

# 按键事件 (Key Event)给设备发送一个按键事件
driver.keyevent(176)

# 获取当前的activity
driver.current_activity

# 触摸动作(TouchAction) / 多点触摸动作(MultiTouchAction)
action = TouchAction(driver)
action.press(element=el, x=10, y=10).release().perform()

# 滑动(Swipe)模拟用户滑动
# 注意：appium滑动规则是x从左到右变大，y从上到下变大
driver.swipe(start=75, starty=500, endx=75, endy=0, duration=800)

# 捏 (Pinch)捏屏幕 (双指往内移动来缩小屏幕)
driver.pinch(element=el)

# 放大 (Zoom)放大屏幕 (双指往外移动来放大屏幕)
driver.zoom(element=el)

# 滑动到某个元素 (Scroll To)
todo: python

# 从设备中拉出文件 (Pull File)
driver.pull_file('Library/AddressBook/AddressBook.sqlitedb')

# 推送文件到设备中去
data = "some data for the file"
path = "/data/local/tmp/file.txt"
driver.push_file(path, data.encode('base64'))

# 断言
Assert.assertEquals("I am a div", div.getText()); //跳转到指定页面并在该页面所以用元素id进行交互

# 检查文本是否符合预期
assertEqual('I am a div', div.text)

# 输入法是否有活动 返回真假
is_ime_active(self):

# 返回当前安卓设备可用的输入法
driver.available_ime_engines(self):

# 激活安卓设备中的制定输入法
driver.activate_ime_engine(self, engine):

# 关闭当前的输入法（android）
driver.deactivate_ime_engine(self):

# 打开安卓设备上的位置定位设置
driver.toggle_location_services()

# 设置设备的经纬度
    :Args:
     - latitude纬度 - String or numeric value between -90.0 and 90.00
     - longitude经度 - String or numeric value between -180.0 and 180.0
     - altitude海拔高度- String or numeric value
用法 driver.set_location(纬度，经度，高度)

# 点击
element.click()

# 清除元素内容
element.clear()

# 返回元素的文本内容
element.text()

# 提交表单
element.submit(self):

# 元素是否可用
element.is_enabled()

# 元素是否可选
element.is_slected()

# 元素是否可见
element.is_displayed()

# 获取元素的大小（高和宽）
new_size["height"] = size["height"]
new_size["width"] = size["width"]
driver.element.size

# 获取元素左上角的坐标
# 用法 driver.element.location
'''返回element的x坐标, int类型'''
driver.element.location.get('x')
'''返回element的y坐标, int类型'''
driver.element.location.get('y')

# 获取当前元素的截图为Base64编码的字符串
img_b64 = element.screenshot_as_base64

# 执行JS
# 在当前窗口/框架（特指 Html 的 iframe ）同步执行 javascript 代码
driver.execute_script('document.title')
# 异步执行代码，其他代码在执行
driver.execute_async_script('document.title')

# 获取当前url
driver.current_url

# 获取页面源
driver.page_source

# 关闭当前窗口
driver.close()


# 关闭应用
driver.quit()

# chrome上进行测试
{
'platformName': 'Android',
'platformVersion': '4.4',
'deviceName': 'Android Emulator',
'browserName': 'Chrome'
}

# 真机测试
{
'automationName': 'Selendroid',
'platformName': 'Android',
'platformVersion': '2.3',
'deviceName': 'Android Emulator',
'app': myApp,
'appPackage': 'com.mycompany.package',
'appActivity': '.MainActivity'
}

# 多点触控
"""
规范中的可用事件有：
* 短按 (press)
* 释放 (release)
* 移动到 (moveTo)
* 点击 (tap)
* 等待 (wait)
* 长按 (longPress)
* 取消 (cancel)
* 执行 (perform)
"""
```

#### 详细版

**1.contexts**
```

contexts(self):

Returnsthecontextswithinthecurrentsession.

返回当前会话中的上下文，使用后可以识别H5页面的控件

:Usage:

driver.contexts

用法driver.contexts
```

**2. current_context**
```

current_context(self):

Returnsthecurrentcontextofthecurrentsession.

返回当前会话的当前上下文

:Usage:

driver.current_context

用法driver.current_context
```

**3. context**
```
context(self):

Returnsthecurrentcontextofthecurrentsession.

返回当前会话的当前上下文。

:Usage:

driver.context

用法driver.Context
```
**4. find_element_by_ios_uiautomation**
```
find_element_by_ios_uiautomation(self, uia_string):

FindsanelementbyuiautomationiniOS.

通过iOSuiautomation查找元素

:Args:

-uia_string-TheelementnameintheiOSUIAutomationlibrary

:Usage:

driver.find_element_by_ios_uiautomation('.elements()[1].cells()[2]')

用法dr.find_element_by_ios_uiautomation(‘elements’)
```
**5. find_element_by_accessibility_id**
```
find_element_by_accessibility_id(self, id):

Findsanelementbyaccessibilityid.

通过accessibilityid查找元素

:Args:

-id-astringcorrespondingtoarecursiveelementsearchusingthe

Id/NamethatthenativeAccessibilityoptionsutilize

:Usage:

driver.find_element_by_accessibility_id()

用法driver.find_element_by_accessibility_id(‘id’)
``````
**6.scroll**
```
scroll(self, origin_el, destination_el):

Scrollsfrom**oneelementtoanother**

从元素**origin_el**滚动至元素**destination_el**

:**Args**:

-**originalEl**-**theelement**from**whichtobeingscrolling**

-**destinationEl**-**theelementtoscrollto**

:**Usage**:
```
**7.driver.scroll**(**el1**,**el2**)

```python
用法 **driver.scroll**(**el1**,**el2**)

**7. drag_and_drop**

drag_and_drop(self, origin_el, destination_el):

Dragtheoriginelementtothedestinationelement

将元素origin_el拖到目标元素destination_el

:Args:

-originEl-theelementtodrag

-destinationEl-theelementtodragto

用法driver.drag_and_drop(el1,el2)
```
**8.tap**
```
tap(self, positions, duration=None):

Tapsonanparticularplacewithuptofivefingers,holdingforacertaintime

模拟手指点击（最多五个手指），可设置按住时间长度（毫秒）

:Args:

-positions-anarrayoftuplesrepresentingthex/ycoordinatesof

thefingerstotap.Lengthcanbeuptofive.

-duration-(optional)lengthoftimetotap,inms

:Usage:

driver.tap([(100,20),(100,60),(100,100)],500)

用法driver.tap([(x,y),(x1,y1)],500)
```
**9. swipe**
```
swipe(self, start_x, start_y, end_x, end_y, duration=None):

Swipefrom**onepointtoanotherpoint**,for**anoptionalduration.**

从**A**点滑动至**B**点，滑动时间为毫秒

:**Args**:

-**start_x**-**x**-**coordinateatwhichtostart**

-**start_y**-**y**-**coordinateatwhichtostart**

-**end_x**-**x**-**coordinateatwhichtostop**

-**end_y**-**y**-**coordinateatwhichtostop**

-**duration**-(**optional**)**timetotaketheswipe**,in**ms.**

:**Usage**:

**driver.swipe**(100,100,100,400)

用法 **driver.swipe**(**x1**,**y1**,**x2**,**y2**,500)
```
**10.flick**
```
flick(self, start_x, start_y, end_x, end_y):

Flickfrom**onepointtoanotherpoint.**

按住**A**点后快速滑动至**B**点

:**Args**:

-**start_x**-**x**-**coordinateatwhichtostart**

-**start_y**-**y**-**coordinateatwhichtostart**

-**end_x**-**x**-**coordinateatwhichtostop**

-**end_y**-**y**-**coordinateatwhichtostop**

:**Usage**:

**driver.flick**(100,100,100,400)

用法 driver.flick(x1,y1,x2,y2)
```
**11.pinch**
```
pinch(self, element=None, percent=200, steps=50):

Pinchonanelementacertainamount

在元素上执行模拟双指捏（缩小操作）

:Args:

-element-theelementtopinch

-percent-(optional)amounttopinch.Defaultsto200%

-steps-(optional)numberofstepsinthepinchaction

:Usage:

driver.pinch(element)

用法 driver.pinch(element)
```
**12.zoom**
```
zoom(self, element=None, percent=200, steps=50):

Zoomsinonanelementacertainamount

在元素上执行放大操作

:Args:

-element-theelementtozoom

-percent-(optional)amounttozoom.Defaultsto200%

-steps-(optional)numberofstepsinthezoomaction

:Usage:

driver.zoom(element)

用法 driver.zoom(element)
```
**13.reset**
```
reset(self):

Resetsthecurrentapplicationonthedevice.

重置应用(类似删除应用数据)

用法driver.reset()
```
**14. hide_keyboard**
```
hide_keyboard(self, key_name=None, key=None, strategy=None):

Hidesthesoftwarekeyboardonthedevice.IniOS,use`key_name`topressaparticularkey,or`strategy`.InAndroid,noparametersareused.

隐藏键盘,iOS使用key_name隐藏，安卓不使用参数

:Args:

-key_name-keytopress

-strategy-strategyforclosingthekeyboard(e.g.,`tapOutside`)

driver.hide_keyboard()
```
**15. keyevent**
```
keyevent(self, keycode, metastate=None):

Sendsakeycodetothedevice.Androidonly.Possiblekeycodescanbefoundinhttp://developer.android.com/reference/android/view/KeyEvent.html.

发送按键码（安卓仅有），按键码可以上网址中找到

:Args:

-keycode-thekeycodetobesenttothedevice

-metastate-metainformationaboutthekeycodebeingsent

用法dr.keyevent(‘4’)
```
**16. press_keycode**
```
press_keycode(self, keycode, metastate=None):

Sendsakeycodetothedevice.Androidonly.Possiblekeycodescanbefoundinhttp://developer.android.com/reference/android/view/KeyEvent.html.

发送按键码（安卓仅有），按键码可以上网址中找到

:Args:

-keycode-thekeycodetobesenttothedevice

-metastate-metainformationaboutthekeycodebeingsent

用法driver.press_keycode(‘4’)

dr.keyevent(‘4’)与driver.press_ keycode(‘4’) 功能实现上一样的，都是按了返回键
```
**17. long_press_keycode**
```
long_press_keycode(self, keycode, metastate=None):

Sendsalongpressofkeycodetothedevice.Androidonly.Possiblekeycodescanbe

foundinhttp://developer.android.com/reference/android/view/KeyEvent.html.

发送一个长按的按键码（长按某键）

:Args:

-keycode-thekeycodetobesenttothedevice

-metastate-metainformationaboutthekeycodebeingsent

用法driver.long_press_keycode(‘4’)
```
**18.current_activity**
```
current_activity(self):

Retrievesthecurrentactivityonthedevice.

获取当前的activity

用法**print**(driver.current_activity())
```
**19. wait_activity**
```
wait_activity(self, activity, timeout, interval=1):

Waitforanactivity:blockuntiltargetactivitypresentsortimeout.

ThisisanAndroid-onlymethod.

等待指定的activity出现直到超时，interval为扫描间隔1秒

即每隔几秒获取一次当前的activity

返回的True或False

:Agrs:

-activity-targetactivity

-timeout-maxwaittime,inseconds

-interval-sleepintervalbetweenretries,inseconds

用法driver.wait_activity(‘.activity.xxx’,5,2)
```
**20. background_app**
```
background_app(self, seconds):

Putstheapplicationinthebackgroundonthedeviceforacertainduration.

后台运行app多少秒

:Args:

-seconds-thedurationfortheapplicationtoremaininthebackground

用法driver.background_app(5)置后台5秒后再运行
```
**21.is_app_installed**
```
is_app_installed(self, bundle_id):

Checkswhethertheapplicationspecifiedby`bundle_id`isinstalledonthedevice.

检查app是否有安装

返回TrueorFalse

:Args:

-bundle_id-theidoftheapplicationtoquery

用法driver.is_app_installed(“com.xxxx”)
```
**22.install_app**
```
install_app(self, app_path):

Installtheapplicationfoundat`app_path`onthedevice.

安装app,app_path为安装包路径

:Args:

-app_path-thelocalorremotepathtotheapplicationtoinstall

用法driver.install_app(app_path)
```
**23.remove_app**
```
remove_app(self, app_id):

Removethespecifiedapplicationfrom**thedevice.**

删除**app**

:**Args**:

-**app_id**-**theapplicationidtoberemoved**

用法 **driver.remove_app**(“**com.xxx.**”)
```
**24.launch_app**
```
launch_app(self):

Startonthedevicetheapplicationspecifiedinthedesiredcapabilities.

启动app

用法driver.launch_app()
```
**25.close_app**
```
close_app(self):

Stoptherunningapplication,specifiedinthedesiredcapabilities,onthedevice.

关闭app

用法driver.close_app()

启动和关闭app运行好像会出错
```
**26. start_activity**
```
start_activity(self, app_package, app_activity, **opts):

Opensanarbitraryactivityduringatest.Iftheactivitybelongsto

anotherapplication,thatapplicationisstartedandtheactivityisopened.

ThisisanAndroid-onlymethod.

在测试过程中打开任意活动。如果活动属于另一个应用程序，该应用程序的启动和活动被打开。

这是一个安卓的方法

:Args:

-app_package-Thepackagecontainingtheactivitytostart.

-app_activity-Theactivitytostart.

-app_wait_package-Beginautomationafterthispackagestarts(optional).

-app_wait_activity-Beginautomationafterthisactivitystarts(optional).

-intent_action-Intenttostart(optional).

-intent_category-Intentcategorytostart(optional).

-intent_flags-Flagstosendtotheintent(optional).

-optional_intent_arguments-Optionalargumentstotheintent(optional).

-stop_app_on_reset-Shouldtheappbestoppedonreset(optional)?

用法driver.start_activity(app_package,app_activity)
``````
**27.lock**
```
lock(self, seconds):

Lockthedeviceforacertainperiodoftime.iOSonly.

锁屏一段时间iOS专有

:Args:

-thedurationtolockthedevice,inseconds

用法driver.lock()
```
**28.shake**
```
shake(self):

Shakethedevice.

摇一摇手机

用法driver.shake()
```
**29.open_notifications**
```
open_notifications(self):

OpennotificationshadeinAndroid(APILevel18andabove)

打系统通知栏（仅支持API18以上的安卓系统）

用法driver.open_notifications()
```
**30.network_connection**
```
network_connection(self):

Returnsanintegerbitmaskspecifyingthenetworkconnectiontype.

Androidonly.

返回网络类型数值

Possiblevaluesareavailablethroughtheenumeration`appium.webdriver.ConnectionType`

用法driver.network_connection
``````
**31. set_network_connection**
```
set_network_connection(self, connectionType):

Setsthenetworkconnectiontype.Androidonly.

Possiblevalues:

Value(Alias)|Data|Wifi|AirplaneMode

\-------------------------------------------------

0(None)|0|0|0

1(AirplaneMode)|0|0|1

2(Wifionly)|0|1|0

4(Dataonly)|1|0|0

6(Allnetworkon)|1|1|0

Theseareavailablethroughtheenumeration`appium.webdriver.ConnectionType`

设置网络类型

:Args:

-connectionType-amemberoftheenumappium.webdriver.ConnectionType

用法先加载from**appium.webdriver.connectiontype**importConnectionType

dr.set_network_connection(ConnectionType.WIFI_ONLY)

ConnectionType的类型有

NO_CONNECTION=0

AIRPLANE_MODE=1

WIFI_ONLY=2

DATA_ONLY=4

ALL_NETWORK_ON=6
```
**32. available_ime_engines**
```
available_ime_engines(self):

GettheavailableinputmethodsforanAndroiddevice.Packageandactivityarereturned(e.g.,['com.android.inputmethod.latin/.LatinIME'])

Androidonly.

返回安卓设备可用的输入法

用法**print**(driver.available_ime_engines)
```
**33.is_ime_active**
```
is_ime_active(self):

CheckswhetherthedevicehasIMEserviceactive.ReturnsTrue/False.

Androidonly.

检查设备是否有输入法服务活动。返回真/假。

安卓

用法**print**(driver.is_ime_active())
```
**34.activate_ime_engine**
```
activate_ime_engine(self, engine):

ActivatesthegivenIMEengineonthedevice.

Androidonly.

激活安卓设备中的指定输入法，设备可用输入法可以从“available_ime_engines”获取

:Args:

-engine-thepackageandactivityoftheIMEenginetoactivate(e.g.,

'com.android.inputmethod.latin/.LatinIME')

用法driver.activate_ime_engine(“com.android.inputmethod.latin/.LatinIME”)
```
**35.deactivate_ime_engine**
```
deactivate_ime_engine(self):

DeactivatesthecurrentlyactiveIMEengineonthedevice.

Androidonly.

关闭安卓设备当前的输入法

用法driver.deactivate_ime_engine()
```
**36.active_ime_engine**
```
active_ime_engine(self):

ReturnstheactivityandpackageofthecurrentlyactiveIMEengine(e.g.,

'com.android.inputmethod.latin/.LatinIME').

Androidonly.

返回当前输入法的包名

用法driver.active_ime_engine
```
**37. toggle_location_services**
```
toggle_location_services(self):

Togglethelocationservicesonthedevice.Androidonly.

打开安卓设备上的位置定位设置

用法driver.toggle_location_services()
```
**38.set_location**
```
set_location(self, latitude, longitude, altitude):

Setthelocationofthedevice

设置设备的经纬度

:Args:

-latitude纬度-Stringornumericvaluebetween-90.0and90.00

-longitude经度-Stringornumericvaluebetween-180.0and180.0

-altitude海拔高度-Stringornumericvalue

用法driver.set_location(纬度，经度，高度)
```
**39.tag_name**
```
tag_name(self):

Thiselement's ``tagName`` property.

返回元素的tagName属性

经实践返回的是class name

用法 element.tag_name()
```
**40.text**
```
text(self):

Thetextoftheelement.

返回元素的文本值

用法element.text()
```
**41.click**
```
click(self):

Clickstheelement.

点击元素

用法element.click()
```
**42.submit**
```
submit(self):

Submitsaform.

提交表单

用法暂无
```
**43.clear**
```
clear(self):

Clearsthetextifit's a text entry element.

​    清除输入的内容

用法 element.clear()
```
**44.get_attribute**
```
get_attribute(self, name):

详见[@chenhengjie123](https://testerhome.com/chenhengjie123) 的[超级链接](https://testerhome.com/topics/2606)

Getsthegivenattributeorpropertyoftheelement.

1、获取content-desc的方法为get_attribute("name")，而且还不能保证返回的一定是content-desc（content-desc为空时会返回text属性值）

2、get_attribute方法不是我们在uiautomatorviewer看到的所有属性都能获取的（此处的名称均为使用get_attribute时使用的属性名称）：

可获取的：

字符串类型：

name(返回content-desc或text)

text(返回text)

className(返回class，只有API=>18才能支持)

resourceId(返回resource-id，只有API=>18才能支持)

Thismethodwillfirsttrytoreturnthevalueofapropertywiththe

givenname.Ifapropertywiththatnamedoesn'texist, itreturnsthe

valueoftheattributewiththesamename. Ifthere'snoattributewith

thatname,``None``isreturned.

Valueswhichareconsideredtruthy,thatisequals"true"or"false",

arereturnedasbooleans.Allothernon-``None``valuesarereturned

asstrings.Forattributesorpropertieswhichdonotexist,``None``

isreturned.

:Args:

-name-Nameoftheattribute/propertytoretrieve.

Example::

*# Check if the "active" CSS class is applied to an element.*

is_active="active"intarget_element.get_attribute("class")

用法暂无
```
**45.is_selected**
```
is_selected(self):

Returnswhethertheelementisselected.

Canbeusedtocheckifacheckboxorradiobuttonisselected.

返回元素是否选择。

可以用来检查一个复选框或单选按钮被选中。

用法element.is_slected()
```
**46.is_enabled**
```
is_enabled(self):

Returnswhethertheelementisenabled.

返回元素是否可用TrueofFalse

用法element.is_enabled()
```
**47.find_element_by_id**
```
find_element_by_id(self, id_):

Findselementwithinthiselement's children by ID.

​    通过元素的ID定位元素

​    :Args:

​        \- id_ - ID of child element to locate.

用法 driver. find_element_by_id(“id”)
```
**48. find_elements_by_id**
```
find_elements_by_id(self, id_):

Findsalistofelementswithinthiselement's children by ID.

​    通过元素ID定位,含有该属性的所有元素

​    :Args:

​        \- id_ - Id of child element to find.

用法 driver. find_elements_by_id(“id”)
```
**49. find_element_by_name**
```
find_element_by_name(self, name):

Findselementwithinthiselement's children by name.

​     通过元素Name定位（元素的名称属性text）

​    :Args:

​        \- name - name property of the element to find.

用法 driver.find_element_by_name(“name”)
```
**50. find_elements_by_name**
```
find_elements_by_name(self, name):

Findsalistofelementswithinthiselement's children by name.

​    通过元素Name定位（元素的名称属性text），含有该属性的所有元素

​    :Args:

​        \- name - name property to search for.

用法 driver.find_element_by_name(“name”)
```
**51. find_element_by_link_text**
```
find_element_by_link_text(self, link_text):

Findselementwithinthiselement's children by visible link text.

​    通过元素可见链接文本定位

​    :Args:

​        \- link_text - Link text string to search for.

用法 driver.find_element_by_link_text(“text”)
```
**52. find_elements_by_link_text**
```
find_element_by_link_text(self, link_text):

Findsalistofelementswithinthiselement's children by visible link text

​    通过元素可见链接文本定位,含有该属性的所有元素

​    :Args:

​        \- link_text - Link text string to search for.

用法 driver.find_elements_by_link_text(“text”)
```
**53. find_element_by_partial_link_text**
```
find_element_by_partial_link_text(self, link_text):

Findselementwithinthiselement's children by partially visible link text.

​    通过元素部分可见链接文本定位

​    :Args:

​        \- link_text - Link text string to search for.

driver. find_element_by_partial_link_text(“text”)
```
**54. find_elements_by_partial_link_text**
```
find_elements_by_partial_link_text(self, link_text):

Findsalistofelementswithinthiselement's children by link text.

​    通过元素部分可见链接文本定位,含有该属性的所有元素

​    :Args:

​        \- link_text - Link text string to search for.

driver. find_elements_by_partial_link_text(“text”)
```
**55. find_element_by_tag_name**
```
find_element_by_tag_name(self, name):

Findselementwithinthiselement's children by tag name.

​    通过查找html的标签名称定位元素

​    :Args:

​        \- name - name of html tag (eg: h1, a, span)

用法  driver.find_element_by_tag_name(“name”)
```
**56. find_elements_by_tag_name**
```
find_elements_by_tag_name(self, name):

Findsalistofelementswithinthiselement's children by tag name.

   通过查找html的标签名称定位所有元素

​    :Args:

​        \- name - name of html tag (eg: h1, a, span)

用法driver.find_elements_by_tag_name(“name”)
```
**57. find_element_by_xpath**
```
find_element_by_xpath(self, xpath):

Findselementbyxpath.

通过Xpath定位元素，详细方法可参阅http://www.w3school.com.cn/xpath/

:Args:

xpath-xpathofelementtolocate."//input[@class='myelement']"

Note:Thebasepathwillberelativetothiselement's location.

​    This will select the first link under this element.

​    ::

​        myelement.find_elements_by_xpath(".//a")

​    However, this will select the first link on the page.

​    ::

​        myelement.find_elements_by_xpath("//a")

用法 find_element_by_xpath(“//*”)
```
**58. find_elements_by_xpath**
```
find_elements_by_xpath(self, xpath):

Findselementswithintheelementbyxpath.

:Args:

-xpath-xpathlocatorstring.

Note:Thebasepathwillberelativetothiselement's location.

​    This will select all links under this element.

​    ::

​        myelement.find_elements_by_xpath(".//a")

​    However, this will select all links in the page itself.

​    ::

​        myelement.find_elements_by_xpath("//a")

用法find_elements_by_xpath(“//*”)
```
**59. find_element_by_class_name**
```
find_element_by_class_name(self, name):

Findselementwithinthiselement's children by class name.

​    通过元素class name属性定位元素

​    :Args:

​        \- name - class name to search for.

用法 driver. find_element_by_class_name(“android.widget.LinearLayout”)
```
**60. find_elements_by_class_name**
```
find_elements_by_class_name(self, name):

Findsalistofelementswithinthiselement's children by class name.

​    通过元素class name属性定位所有含有该属性的元素

​    :Args:

​        \- name - class name to search for.

用法 driver. find_elements_by_class_name(“android.widget.LinearLayout”)
```
**61. find_element_by_css_selector**
```
find_element_by_css_selector(self, css_selector):

Findselementwithinthiselement's children by CSS selector.

​    通过CSS选择器定位元素

​    :Args:

​        \- css_selector - CSS selctor string, ex: 'a.nav*#home'*
```
**62.send_keys**
```
send_keys(self, *value):

Simulatestypingintotheelement.

在元素中模拟输入（开启appium自带的输入法并配置了appium输入法后，可以输入中英文）

:Args:

-value-Astringfortyping,orsettingformfields.Forsetting

fileinputs,thiscouldbealocalfilepath.

Usethistosendsimplekeyeventsortofilloutformfields::

form_textfield=driver.find_element_by_name('username')

form_textfield.send_keys("admin")

Thiscanalsobeusedtosetfileinputs.

::

file_input=driver.find_element_by_name('profilePic')

file_input.send_keys("path/to/profilepic.gif")

*# Generally it's better to wrap the file path in one of the methods*

*# in os.path to return the actual path to support cross OS testing.*

*# file_input.send_keys(os.path.abspath("path/to/profilepic.gif"))*

driver.element.send_keys(“中英”)
```
**63. is_displayed**
```
is_displayed(self):

Whethertheelementisvisibletoauser.

此元素用户是否可见。简单地说就是隐藏元素和被控件挡住无法操作的元素（仅限Selenium，appium是否实现了类似功能不是太确定）这一项都会返回False

用法driver.element.is_displayed()
```
**64. location_once_scrolled_into_view**
```
location_once_scrolled_into_view(self):

"""THIS PROPERTY MAY CHANGE WITHOUT WARNING. Use this to discover

​    where on the screen an element is so that we can click it. This method

​    should cause the element to be scrolled into view.

​    Returns the top lefthand corner location on the screen, or ``None`` if

​    the element is not visible.

​    暂不知道用法

​    """
```
**65.size**
```
size(self):

Thesizeoftheelement.

获取元素的大小（高和宽）

new_size["height"]=size["height"]

new_size["width"]=size["width"]

用法driver.element.size
```
**66. value_of_css_property**
```
value_of_css_property(self, property_name):

ThevalueofaCSSproperty.

CSS属性

用法暂不知
```
**67.location**
```
location(self):

Thelocationoftheelementintherenderablecanvas.

获取元素左上角的坐标

用法driver.element.location

'''返回element的x坐标, int类型'''

driver.element.location.get('x')

'''返回element的y坐标, int类型'''

driver.element.location.get('y')
```
**68.rect**
```
rect(self):

Adictionarywiththesizeandlocationoftheelement.

元素的大小和位置的字典
```
**69. screenshot_as_base64**
```
screenshot_as_base64(self):

Getsthescreenshotofthecurrentelementasabase64encodedstring.

获取当前元素的截图为Base64编码的字符串

:Usage:

img_b64=element.screenshot_as_base64
```
**70.execute_script**
```
execute_script(self, script, *args):

SynchronouslyExecutesJavaScriptinthecurrentwindow/frame.

在当前窗口/框架（特指Html的iframe）同步执行javascript代码。你可以理解为如果这段代码是睡眠5秒，这五秒内主线程的javascript不会执行

:Args:

-script:TheJavaScripttoexecute.

\- \*args:AnyapplicableargumentsforyourJavaScript.

:Usage:

driver.execute_script('document.title')
```
**71.execute_async_script**
```
execute_async_script(self, script, *args):

AsynchronouslyExecutesJavaScriptinthecurrentwindow/frame.

插入javascript代码，只是这个是异步的，也就是如果你的代码是睡眠5秒，那么你只是自己在睡，页面的其他javascript代码还是照常执行

:Args:

-script:TheJavaScripttoexecute.

\- \*args:AnyapplicableargumentsforyourJavaScript.

:Usage:

driver.execute_async_script('document.title')
```
**72.current_url**
```
current_url(self):

GetstheURLofthecurrentpage.

获取当前页面的网址。

:Usage:

driver.current_url

用法driver.current_url
```
**73. page_source**
```
page_source(self):

Getsthesourceofthecurrentpage.

获取当前页面的源。

:Usage:

driver.page_source
```
**74.close**
```
close(self):

Closesthecurrentwindow.

关闭当前窗口

:Usage:

driver.close()
```
**75.quit**
```
quit(self):

Quitsthedriverandcloseseveryassociatedwindow.

退出脚本运行并关闭每个相关的窗口连接

:Usage:

driver.quit()
```

#### Appium 服务器参数

```bash


使用方法: node . [标志]
服务器标志

所有的标志都是可选的，但是有一些标志需要组合在一起才能生效。

<expand_table>
标志 默认值 描述 例子
--shell null 进入 REPL 模式
--localizable-strings-dir en.lproj IOS only: 定位 .strings所在目录的相对路径 --localizable-strings-dir en.lproj
--app null iOS: 基于模拟器编译的 app 的绝对路径或者设备目标的 bundle_id； Android: apk 文件的绝对路径--app /abs/path/to/my.app
--ipa null (IOS-only) .ipa 文件的绝对路径 --ipa /abs/path/to/my.ipa
-U, --udid null 连接物理设备的唯一设备标识符 --udid 1adsf-sdfas-asdf-123sdf
-a, --address 0.0.0.0 监听的 ip 地址 --address 0.0.0.0
-p, --port 4723 监听的端口 --port 4723
-ca, --callback-address null 回调IP地址 (默认: 相同的IP地址) --callback-address 127.0.0.1
-cp, --callback-port null 回调端口号 (默认: 相同的端口号) --callback-port 4723
-bp, --bootstrap-port 4724 (Android-only) 连接设备的端口号 --bootstrap-port 4724
-k, --keep-artifacts false 弃用，无效。trace信息现在保留tmp目录下，每次运行前会清除该目录中的信息。 也可以参考 --trace-dir 。
-r, --backend-retries 3 (iOS-only) 遇到 crash 或者 超时，Instrument 重新启动的次数。 --backend-retries 3
--session-override false 允许 session 被覆盖 (冲突的话)
--full-reset false (iOS) 删除整个模拟器目录。 (Android) 通过卸载应用（而不是清除数据）重置应用状态。在 Android 上，session 完成后也会删除应用。
--no-reset false session 之间不重置应用状态 (iOS: 不删除应用的 plist 文件； Android: 在创建一个新的 session 前不删除应用。)
-l, --pre-launch false 在第一个 session 前，预启动应用 (iOS 需要 --app 参数，Android 需要 --app-pkg 和 --app-activity)
-lt, --launch-timeout 90000 (iOS-only) 等待 Instruments 启动的时间
-g, --log null 将日志输出到指定文件 --log /path/to/appium.log
--log-level debug 日志级别; 默认 (console[:file]): debug[:debug] --log-level debug
--log-timestamp false 在终端输出里显示时间戳
--local-timezone false 使用本地时间戳
--log-no-colors false 不在终端输出中显示颜色
-G, --webhook null 同时发送日志到 HTTP 监听器 --webhook localhost:9876
--native-instruments-lib false (IOS-only) iOS 内建了一个怪异的不可能避免的延迟。我们在 Appium 里修复了它。如果你想用原来的，你可以使用这个参数。
--app-pkg null (Android-only) 你要运行的apk的java包。 (例如， com.example.android.myApp) --app-pkg com.example.android.myApp
--app-activity null (Android-only) 打开应用时，启动的 Activity 的名字(比如， MainActivity) --app-activity MainActivity
--app-wait-package false (Android-only) 你想等待的 Activity 的包名。(比如， com.example.android.myApp) --app-wait-package com.example.android.myApp
--app-wait-activity false (Android-only) 你想等待的 Activity 名字(比如， SplashActivity) --app-wait-activity SplashActivity
--android-coverage false (Android-only) 完全符合条件的 instrumentation 类。 作为命令 adb shell am instrument -e coverage true -w 的 -w 的参数 --android-coverage com.my.Pkg/com.my.Pkg.instrumentation.MyInstrumentation
--avd null (Android-only) 要启动的 avd 的名字
--avd-args null (Android-only) 添加额外的参数给要启动avd --avd-args -no-snapshot-load
--device-ready-timeout 5 (Android-only) 等待设备准备好的时间，以秒为单位 --device-ready-timeout 5
--safari false (IOS-Only) 使用 Safari 应用
--device-name null 待使用的移动设备名字 --device-name iPhone Retina (4-inch), Android Emulator
--platform-name null 移动平台的名称: iOS, Android, or FirefoxOS --platform-name iOS
--platform-version null 移动平台的版本 --platform-version 7.1
--automation-name null 自动化工具的名称: Appium or Selendroid --automation-name Appium
--browser-name null 移动浏览器的名称: Safari or Chrome --browser-name Safari
--default-device, -dd false (IOS-Simulator-only) 使用instruments自己启动的默认模拟器
--force-iphone false (IOS-only) 无论应用要用什么模拟器，强制使用 iPhone 模拟器
--force-ipad false (IOS-only) 无论应用要用什么模拟器，强制使用 iPad 模拟器
--language null iOS / Android 模拟器的语言 --language en
--locale null Locale for the iOS simulator / Android Emulator --locale en_US
--calendar-format null (IOS-only) iOS 模拟器的日历格式 --calendar-format gregorian
--orientation null (IOS-only) 初始化请求时，使用 LANDSCAPE (横屏) 或者 PORTRAIT (竖屏) --orientation LANDSCAPE
--tracetemplate null (IOS-only) 指定 Instruments 使用的 tracetemplate 文件 --tracetemplate /Users/me/Automation.tracetemplate
--show-sim-log false (IOS-only) 如果设置了， iOS 模拟器的日志会写到终端上来
--show-ios-log false (IOS-only) 如果设置了， iOS 系统的日志会写到终端上来
--nodeconfig null 指定 JSON 格式的配置文件 ，用来在 selenium grid 里注册 appiumd --nodeconfig /abs/path/to/nodeconfig.json
-ra, --robot-address 0.0.0.0 robot 的 ip 地址 --robot-address 0.0.0.0
-rp, --robot-port -1 robot 的端口地址 --robot-port 4242
--selendroid-port 8080 用来和 Selendroid 交互的本地端口 --selendroid-port 8080
--chromedriver-port 9515 ChromeDriver运行的端口 --chromedriver-port 9515
--chromedriver-executable null ChromeDriver 可执行文件的完整路径
--use-keystore false (Android-only) 设置签名 apk 的 keystore
--keystore-path (Android-only) keystore 的路径
--keystore-password android (Android-only) keystore 的密码
--key-alias androiddebugkey (Android-only) Key 的别名
--key-password android (Android-only) Key 的密码
--show-config false 打印 Appium 服务器的配置信息，然后退出
--no-perms-check false 跳过Appium对是否可以读/写必要文件的检查
--command-timeout 60 默认所有会话的接收命令超时时间 (在超时时间内没有接收到新命令，自动关闭会话)。 会被新的超时时间覆盖
--keep-keychains false (iOS) 当 Appium 启动或者关闭的时候，是否保留 keychains (Library/Keychains)
--strict-caps false 如果所选设备是appium不承认的有效设备，会导致会话失败
--isolate-sim-device false Xcode 6存在一个bug，那就是一些平台上如果其他模拟器设备先被删除时某个特定的模拟器只能在没有任何错误的情况下被建立。这个选项导致了Appium不得不删除除了正在使用设备以外其他所有的设备。请注意这是永久性删除，你可以使用simctl或xcode管理被Appium使用的设备类别。
--tmp null 可以被Appium用来管理临时文件的目录（绝对路径），比如存放需要移动的内置iOS应用程序。 默认的变量为 APPIUM_TMP_DIR ，在 *nix/Mac 为 /tmp 在windows上使用环境便令 TEMP 设定的目录。
--trace-dir null 用于保存iOS instruments trace的 appium 目录，是绝对路径， 默认为 <tmp dir>/appium-instruments
--intent-action android.intent.action.MAIN (Android-only) 用于启动 activity 的intent action --intent-action android.intent.action.MAIN
--intent-category android.intent.category.LAUNCHER (Android-only) 用于启动 activity 的intent category --intent-category android.intent.category.APP_CONTACTS
--intent-flags 0x10200000 (Android-only) 启动 activity 的标志 --intent-flags 0x10200000
--intent-args null (Android-only) 启动 activity 时附带额外的 intent 参数 --intent-args 0x10200000
--suppress-adb-kill-server false (Android-only) 如果被设定，阻止Appium杀掉adb实例。
```
