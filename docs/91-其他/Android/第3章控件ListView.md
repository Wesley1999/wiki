# 第3章控件ListView

1.  在活动中添加ListView控件，跟普通控件没有区别：
    

~~~
<?xml version="1.0"?>
<ListView android:id="@+id/list_view" android:layout_width="match_parent" android:layout_height="match_parent"></ListView>
~~~

2.  ListView控件是子项布局的，需要在layout中创建它的子项布局，例如fruit\_item.xml：
    

~~~
<?xml version="1.0" encoding="utf-8"?>
<!--这是ListView的子项布局-->
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android" android:layout_width="match_parent" android:layout_height="match_parent">
    <ImageView android:id="@+id/fruit_image" android:layout_width="wrap_content" android:layout_height="wrap_content" />
    <TextView android:id="@+id/fruit_name" android:layout_width="match_parent" android:layout_height="match_parent" android:layout_gravity="center_vertical" android:layout_margin="10dp" />
</LinearLayout>
~~~

3.  活动中的数据无法直接传给ListView，需要借助适配器来完成，最好的适配器选择是ArrayAdapter。
    

~~~
public class FruitAdapter extends ArrayAdapter<Fruit> {
    private int resourceId;
    /**     
    * @param context 上下文     
    * @param textViewResourceId 子项布局id     
    * @param objects 要适配的数据     */
    public FruitAdapter(Context context, int textViewResourceId, List<Fruit> objects) {
        super(context, textViewResourceId, objects);
        resourceId = textViewResourceId;
    }
    // 会在每个子项被滚到屏幕内时调用    
    @Override    public View getView(int position, View convertView, ViewGroup parent) {
        Fruit fruit = getItem(position);
        //fruit是当前项的实例        
        // 第三个参数false戳规范写法，暂时不必理解        
        View view = LayoutInflater.from(getContext()).inflate(resourceId, parent, false);
        ImageView fruitImage = (ImageView) view.findViewById(R.id.fruit_image);
        TextView fruitName = (TextView) view.findViewById(R.id.fruit_name);
        fruitImage.setImageResource(fruit.getImageId());
        fruitName.setText(fruit.getName());
        return view;
    }
}
~~~

*   适配器中重写的getView()方法会在每个子项被滚到屏幕内时调用。
    

4.  在活动中完成ListView界面：
    

~~~
public class Activity1 extends AppCompatActivity {
    private List<Fruit> fruitList = new ArrayList<Fruit>();
    @Override    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_1);
        initFruits();
        // 初始化水果数据 
        FruitAdapter adapter = new FruitAdapter(Activity1.this, R.layout.fruit_item, fruitList);
        ListView listView = (ListView) findViewById(R.id.list_view);
        listView.setAdapter(adapter);
    }
    private void initFruits() {
        for (int i = 0; i < 20; i++) {
            Fruit apple = new Fruit("Apple", R.drawable.apple_pic);
            fruitList.add(apple);
            Fruit banana = new Fruit("Banana", R.drawable.banana_pic);
            fruitList.add(banana);
            // ...
        }
    }
}
~~~

*   至此，就是完成ListView的基本过程。
    

5.  按上面的做法，每次滚动时布局都会重新加载，这会成为性能的瓶颈。改进上面的getView()方法可以解决此问题：
    

~~~
// 会在每个子项被滚到屏幕内时调用
@Overridepublic View getView(int position, View convertView, ViewGroup parent) {
    Fruit fruit = getItem(position);
    //fruit是当前项的实例
    View view;
    if (convertView == null) {
        view = LayoutInflater.from(getContext()).inflate(resourceId, parent, false);
    } else {
        view = convertView;
    }
    // 第三个参数false是规范写法，暂时不必理解 
    ImageView fruitImage = (ImageView) view.findViewById(R.id.fruit_image);
    TextView fruitName = (TextView) view.findViewById(R.id.fruit_name);
    fruitImage.setImageResource(fruit.getImageId());
    fruitName.setText(fruit.getName());
    return view;
}
~~~

*   这个方法里的convertView参数用于将之前加载好的布局进行缓存，一边之后可以直接重用。
    

6.  继承的适配器还可以继续优化，对控件的实例进行缓存，我已经看不懂了，代码是这样的：
    

~~~
public class FruitAdapter extends ArrayAdapter<Fruit> {
    private int resourceId;
    public FruitAdapter(Context context, int textViewResourceId,                        List<Fruit> objects) {
        super(context, textViewResourceId, objects);
        resourceId = textViewResourceId;
    }
    @Override    public View getView(int position, View convertView, ViewGroup parent) {
        Fruit fruit = getItem(position);
        // 获取当前项的Fruit实例
        View view;
        ViewHolder viewHolder;
        if (convertView == null) {
            view = LayoutInflater.from(getContext()).inflate(resourceId, parent, false);
            viewHolder = new ViewHolder();
            viewHolder.fruitImage = (ImageView) view.findViewById (R.id.fruit_image);
            viewHolder.fruitName = (TextView) view.findViewById (R.id.fruit_name);
            view.setTag(viewHolder);
            // 将ViewHolder存储在View中
        } else {
            view = convertView;
            viewHolder = (ViewHolder) view.getTag();
            // 重新获取ViewHolder
        }
        viewHolder.fruitImage.setImageResource(fruit.getImageId());
        viewHolder.fruitName.setText(fruit.getName());
        return view;
    }
    class ViewHolder {
        ImageView fruitImage;
        TextView fruitName;
    }
}
~~~

7.  ListView中的子项可以添加点击事件。当用户点击ListView的任何一个子项时，就会调用onItemClick()方法，在这个方法中可以通过position参数判断出用户点击的是哪一个子项。
    

*   添加后的onCreate()方法是这样的：
    

~~~
@Overrideprotected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    setContentView(R.layout.activity_1);
    initFruits();
    // 初始化水果数据
    FruitAdapter adapter = new FruitAdapter(Activity1.this, R.layout.fruit_item, fruitList);
    ListView listView = (ListView) findViewById(R.id.list_view);
    listView.setAdapter(adapter);
    listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
        @Override        public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
            Fruit fruit = fruitList.get(position);
            Toast.makeText(Activity1.this, fruit.getName(), Toast.LENGTH_sHORT).show();
        }
    }
    );
}
~~~