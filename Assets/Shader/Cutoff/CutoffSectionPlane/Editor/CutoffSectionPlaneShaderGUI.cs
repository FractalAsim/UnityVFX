using UnityEditor;
public class CutoffSectionPlaneShaderGUI : ShaderGUI
{
    public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] properties)
    {
        MaterialProperty _Enable = FindProperty("_Enable", properties);
        MaterialProperty _PNormal = FindProperty("_PNormal", properties);
        MaterialProperty _PCenter = FindProperty("_PCenter", properties);
        materialEditor.DefaultShaderProperty(_Enable, "_Enable");
        materialEditor.DefaultShaderProperty(_PNormal, "_PNormal");
        materialEditor.DefaultShaderProperty(_PCenter, "_PCenter");

        StandardShaderGUI t = new();
        t.OnGUI(materialEditor, properties);
    }
}