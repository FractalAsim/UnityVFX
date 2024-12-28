using UnityEditor;
public class CutoffXYZShaderGUI : ShaderGUI
{
    public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] properties)
    {
        MaterialProperty _XCutoff = FindProperty("_XCutoff", properties);
        MaterialProperty _YCutoff = FindProperty("_YCutoff", properties);
        MaterialProperty _ZCutoff = FindProperty("_ZCutoff", properties);
        materialEditor.DefaultShaderProperty(_XCutoff, "_XCutoff");
        materialEditor.DefaultShaderProperty(_YCutoff, "_YCutoff");
        materialEditor.DefaultShaderProperty(_ZCutoff, "_ZCutoff");

        MaterialProperty _MinCutoff = FindProperty("_MinCutoff", properties);
        MaterialProperty _MaxCutoff = FindProperty("_MaxCutoff", properties);
        materialEditor.DefaultShaderProperty(_MinCutoff, "_MinCutoff");
        materialEditor.DefaultShaderProperty(_MaxCutoff, "_MaxCutoff");

        MaterialProperty _Reverse = FindProperty("_Reverse", properties);
        materialEditor.DefaultShaderProperty(_Reverse, "_Reverse");

        StandardShaderGUI t = new();
        t.OnGUI(materialEditor, properties);
    }
}