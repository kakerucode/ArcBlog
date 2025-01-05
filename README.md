# ArcBlog

### 项目简介
该project为展示arc blog的demo app。
- 主页显示文章列表，由修改时间最新到最旧排列。点击任意item，页面迁移加载webview显示文章详细内容。

### 项目架构说明
- project架构为MVVM架构。
- project完全由iOS原生库写成，未采用任何第三方类库。minimum target为iOS18.0，请使用Xcode16进行build，即可在本地运行。
- 开发中尽量采用近年来Apple新推出的框架及技术。
    - UI部分采用SwiftUI。
    - 网络层采用concurrency。
    - 尝试采用新接口来解决开发中的问题。例如采用iOS18推出的ScrollPostion来监听ScrollView的滚动状态，而非传统的preferenceKey；采用micro @Observation来取代ObservableObject协议, etc.
    - 故minimum target设定为iOS18.

### 开发中遇到的一些问题
- api接口没有提供文档，故response的数据结构可能有缺失，字段是否为可选项的推断也根据我的经验进行的设定，不一定准确，但可以保障数据解析成功。如果有文档，model的数据结构可以设计的更好，采用enum替代，例如labels，status, etc.
- label是如何映射的，目前直接采用的server返回值直接显示的策略。以及里面混杂了**"assign:z1VhejtzVzeCSXPdCAks5x2p5BUJQhzi4SE"**这种数据，project中做了临时的过滤处理。




