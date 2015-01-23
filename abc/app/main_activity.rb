class MainActivity < Android::App::Activity
  def onCreate(savedInstanceState)
    super

    layout = Android::Widget::LinearLayout.new(self)
    layout.orientation = Android::Widget::LinearLayout::VERTICAL

    @text = Android::Widget::TextView.new(self)
    @text.textColor = Android::Graphics::Color::WHITE
    @text.gravity = Android::View::Gravity::CENTER_HORIZONTAL
    @text.textSize = 40.0
    @text.text = "this is activity a!"
    layout.addView(@text) 
 
    button = Android::Widget::Button.new(self)
    button.text = 'Start B'
    button.onClickListener = self
    layout.addView(button) 
    
    button = Android::Widget::Button.new(self)
    button.text = 'Start C'
    @c_listener = CListener.new(self)
    button.onClickListener = @c_listener
    layout.addView(button) 

    self.contentView = layout    
  end

  def onClick(view)
    intent = Android::Content::Intent.new(self, BActivity)
    startActivity(intent)
  end

  def onActivityResult(request_code, result_code, data)
    super
    puts 'a:' + data.getStringExtra("hello").to_s
    @text.text = data.getStringExtra("hello")
  end
end

class CListener
  def initialize(main)
    @main = main
  end

  def onClick(view)
    intent = Android::Content::Intent.new(@main, CActivity)
    @main.startActivityForResult(intent, 99)    
  end
end
