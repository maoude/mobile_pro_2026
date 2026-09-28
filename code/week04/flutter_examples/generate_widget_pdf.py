from reportlab.pdfgen import canvas
from reportlab.lib.pagesizes import A4

pdf_path = 'widgets_and_types_notes.pdf'

c = canvas.Canvas(pdf_path, pagesize=A4)
width, height = A4

lines = [
    'Flutter Widgets, Their Types and Parameters',
    '',
    'What is a widget?',
    'A widget is the basic building block of every Flutter user interface. Everything in Flutter is a widget, from text and buttons to layout containers and screens. Widgets are nested inside each other to build the interface.',
    '',
    'Widget types',
    'There are two major categories of Flutter widgets:',
    '',
    '1. Visible widgets',
    'These are widgets that show content or receive user input.',
    'Examples: Text, Button, Image, Icon',
    '',
    '2. Invisible widgets',
    'These are widgets that control layout and positioning without being visible themselves.',
    'Examples: Row, Column, Center, Padding, Stack, Scaffold',
    '',
    'Visible widgets',
    'Text:',
    'The Text widget displays text on screen. Common parameters are data, textAlign and style.',
    'Example:',
    'Text(',
    "  'Hello, Flutter!',",
    '  textAlign: TextAlign.center,',
    '  style: TextStyle(fontWeight: FontWeight.bold),',
    ')',
    '',
    'Button:',
    'A button performs an action when pressed. Common parameters include child and onPressed.',
    'Example:',
    'ElevatedButton(',
    '  onPressed: () {},',
    '  child: Text("Click me"),',
    ')',
    '',
    'Image:',
    'The Image widget displays images from assets, network, memory, or files.',
    'Common parameters: width, height, fit, color.',
    '',
    'Icon:',
    'The Icon widget displays a built-in icon from the Flutter Icons library.',
    'Common parameters: Icons.<name>, size, color',
    '',
    'Invisible widgets',
    'Row: arranges children horizontally.',
    'Column: arranges children vertically.',
    'Center: centers a child widget.',
    'Padding: adds space around a widget.',
    'Stack: overlays widgets on top of each other.',
    'Scaffold: creates the screen layout with app bar and body.',
    '',
    'Common widget parameters',
    'child, children, padding, color, width, height, alignment, mainAxisAlignment, crossAxisAlignment, onPressed, style, elevation, textAlign',
    '',
    'Example full app:',
    'import \'package:flutter/material.dart\';',
    '',
    'void main() => runApp(MaterialApp(',
    '  home: Scaffold(',
    '    appBar: AppBar(title: Text(\'Widgets Demo\')),',
    '    body: Center(',
    '      child: Column(',
    '        mainAxisAlignment: MainAxisAlignment.center,',
    '        children: [',
    '          Text(\'Hello, Flutter!\', textAlign: TextAlign.center, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),',
    '          SizedBox(height: 20),',
    '          ElevatedButton(onPressed: () {}, child: Text(\'Click Me\')),',
    '        ],',
    '      ),',
    '    ),',
    '  ),',
    '));',
    '',
    'Summary',
    'Widgets are the basic building blocks of Flutter applications. Visible widgets show content or receive input, while invisible layout widgets arrange and control how visible widgets appear. Understanding widget types and parameters helps us create clean and responsive interfaces.',
]

c.setTitle('Flutter Widgets, Their Types and Parameters')
c.setFont('Helvetica-Bold', 18)
c.drawString(50, height - 50, 'Flutter Widgets, Their Types and Parameters')

c.setFont('Helvetica', 11)
y = height - 90
for line in lines:
    if line == '':
        y -= 14
        continue

    if y < 50:
        c.showPage()
        y = height - 50

    if len(line) > 100:
        wrapped = []
        current = ''
        for word in line.split():
            candidate = current + (' ' if current else '') + word
            if c.stringWidth(candidate, 'Helvetica', 11) > 500:
                wrapped.append(current)
                current = word
            else:
                current = candidate
        if current:
            wrapped.append(current)
        for wline in wrapped:
            c.drawString(50, y, wline)
            y -= 14
            if y < 50:
                c.showPage()
                y = height - 50
    else:
        c.drawString(50, y, line)
        y -= 14

c.save()
print(f'Created PDF: {pdf_path}')
