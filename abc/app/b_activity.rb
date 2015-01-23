class BActivity < Android::App::Activity
  def onCreate(savedInstanceState)
    super

    layout = Android::Widget::LinearLayout.new(self)
    layout.orientation = Android::Widget::LinearLayout::VERTICAL

    text = Android::Widget::TextView.new(self)
    text.textColor = Android::Graphics::Color::WHITE
    text.gravity = Android::View::Gravity::CENTER_HORIZONTAL
    text.textSize = 40.0
    text.text = "this is activity b!"

    layout.addView(text) 

    self.contentView = layout        
  end
end

class CActivity < Android::App::Activity
  def onCreate(savedInstanceState)
    super

    layout = Android::Widget::LinearLayout.new(self)
    layout.orientation = Android::Widget::LinearLayout::VERTICAL

    @textedit = Android::Widget::EditText.new(self)
    layout.addView(@textedit)

    button = Android::Widget::Button.new(self)
    button.text = "click me"
    button.onClickListener = self
    layout.addView(button) 

    self.contentView = layout        
  end

  def onClick(view)
    data = Android::Content::Intent.new
    puts "c:"+@textedit.text.toString.to_s
    data.putExtra("hello", @textedit.text.toString.to_s)
    setResult(Android::App::Activity::RESULT_OK, data)
    finish
  end
end