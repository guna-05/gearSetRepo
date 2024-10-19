global class MyCustomPickList extends VisualEditor.DynamicPickList{
    
    global override VisualEditor.DataRow getDefaultValue(){
        VisualEditor.DataRow defaultValue = new VisualEditor.DataRow('black', 'black');
        return defaultValue;
    }
    global override VisualEditor.DynamicPickListRows getValues() {
        VisualEditor.DataRow value1 = new VisualEditor.DataRow('black', 'black');
        VisualEditor.DataRow value2 = new VisualEditor.DataRow('yellow', 'yellow');
        VisualEditor.DataRow value3 = new VisualEditor.DataRow('green', 'green');
        VisualEditor.DataRow value4 = new VisualEditor.DataRow('blue', 'blue');
        VisualEditor.DynamicPickListRows  myValues = new VisualEditor.DynamicPickListRows();
        myValues.addRow(value1);
        myValues.addRow(value2);
        myValues.addRow(value3);
        myValues.addRow(value4);
        return myValues;
    }
}