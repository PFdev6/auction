module LotsHelper
  def get_all_tag(tags, classes)
    max = tags.sort_by(&:count).last
    tags.each do |tag|
      index = tag.count.to_f / max.count * (classes.size-1)
      yield(tag, classes[index.round])
    end
  end

  def get_imgdescr(lot)
    imgs = []
    imgs.push(lot.first_additional_image) if lot.first_additional_image.file?
    imgs.push(lot.second_additional_image) if lot.second_additional_image.file?
    imgs
  end
end
