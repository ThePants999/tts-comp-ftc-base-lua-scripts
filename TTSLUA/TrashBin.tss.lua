-- FTC-GUID: be2cdb

function onLoad()
    self.createButton({
        click_function="click_clopen", function_owner=self,
        position={0,0.5,0}, height=2000, width=2000, color={0,0,0,0}
    })
    params = {assetbundle="https://chry.me/tts/misc/new_blackhole_test.unity3d",material=2}
end

function click_clopen()
    if self.AssetBundle.getLoopingEffectIndex() == 0 then
        params.type = 6
        self.AssetBundle.playLoopingEffect(1)
    else
        params.type = 0
        self.AssetBundle.playLoopingEffect(0)
    end
    self.setCustomObject(params)
    self.reload()
end

function onCollisionEnter()
    if self.AssetBundle.getLoopingEffectIndex() == 1 then
        self.reset()
    end
end